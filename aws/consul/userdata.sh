#!/bin/bash
# This script is meant to be run in the User Data of each EC2 Instance while it's booting. The script uses the
# run-consul script to configure and start Consul in server mode. Note that this script assumes it's running in an AMI
# built from the Packer template in examples/consul-ami/consul.json.

set -e

# Send the log output from this script to user-data.log, syslog, and the console
# From: https://alestic.com/2010/12/ec2-user-data-output/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

export AWS_DEFAULT_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')

GOSSIP_KEY=$(aws ssm get-parameter --name "/consul/gossip_encryption_key" --with-decryption | jq -r '.Parameter.Value')
aws ssm get-parameter --name "/consul/ca.pem" | jq -r '.Parameter.Value' > ${ca_path}
aws ssm get-parameter --name "/consul/server.pem" | jq -r '.Parameter.Value' > ${cert_file_path}
aws ssm get-parameter --name "/consul/server-key.pem" --with-decryption | jq -r '.Parameter.Value' > ${key_file_path}

/opt/consul/bin/run-consul --server \
  --cluster-tag-key "${cluster_tag_key}" \
  --cluster-tag-value "${cluster_tag_value}" \
  --enable-gossip-encryption \
  --gossip-encryption-key "$GOSSIP_KEY" \
  --enable-rpc-encryption \
  --ca-path ${ca_path} \
  --cert-file-path ${cert_file_path} \
  --key-file-path ${key_file_path}
