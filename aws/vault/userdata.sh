#!/bin/bash
# This script is meant to be run in the User Data of each EC2 Instance while it's booting. The script uses the
# run-consul script to configure and start Consul in client mode and then the run-vault script to configure
# the auto unsealing on server init

set -e

# Send the log output from this script to user-data.log, syslog, and the console
# From: https://alestic.com/2010/12/ec2-user-data-output/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

export AWS_DEFAULT_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')

GOSSIP_KEY=$(aws ssm get-parameter --name "/consul/gossip_encryption_key" --with-decryption | jq -r '.Parameter.Value')
aws ssm get-parameter --name "/consul/ca.pem" | jq -r '.Parameter.Value' > ${consul_ca_path}
aws ssm get-parameter --name "/consul/client.pem" | jq -r '.Parameter.Value' > ${consul_cert_file_path}
aws ssm get-parameter --name "/consul/client-key.pem" --with-decryption | jq -r '.Parameter.Value' > ${consul_key_file_path}

aws ssm get-parameter --name "/vault/vault.pem" | jq -r '.Parameter.Value' > ${vault_cert_file_path}
aws ssm get-parameter --name "/vault/vault-key.pem" --with-decryption | jq -r '.Parameter.Value' > ${vault_key_file_path}

# Run the Consul client agent
/opt/consul/bin/run-consul --client \
  --cluster-tag-key "${cluster_tag_key}" \
  --cluster-tag-value "${cluster_tag_value}" \
  --enable-gossip-encryption \
  --gossip-encryption-key "$GOSSIP_KEY" \
  --enable-rpc-encryption \
  --ca-path ${ca_path} \
  --cert-file-path ${cert_file_path} \
  --key-file-path ${key_file_path}

# Run the Vault server agent
/opt/vault/bin/run-vault \
  --tls-cert-file "${vault_cert_file_path}" \
  --tls-key-file "${vault_key_file_path}" \
  --enable-auto-unseal \
  --auto-unseal-kms-key-id "${kms_key_id}" \
  --auto-unseal-kms-key-region "${aws_region}"

# When you ssh to one of the instances in the vault cluster and initialize the server
# You will notice it will now boot unsealed
# /opt/vault/bin/vault operator init
# /opt/vault/bin/vault status
