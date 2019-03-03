# Consul (AWS)

## Assumptions

### SSM Parameter Store

- `/consul/gossip_encryption_key` (SecureString)
- `/consul/ca.pem`
- `/consul/ca-key.pem` (SecureString)
- `/consul/server.pem`
- `/consul/server-key.pem` (SecureString)

## TODO

- Fix tag `consul-servers` to say `consul`, or something sane (so they can discover each other)
