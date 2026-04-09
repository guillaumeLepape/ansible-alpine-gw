# ansible-alpine-gw

Ansible playbook to deploy an nftables firewall + Caddy reverse proxy on an Alpine Linux VM.

## Features

- Default-drop input/forward policy
- SSH (port 22) restricted to a single allowlisted IPv4 address — all other sources are dropped
- HTTP/HTTPS (80/443) open inbound — Caddy binds directly via `CAP_NET_BIND_SERVICE`
- Automatic TLS via ACME (Let's Encrypt)
- Full IPv4 and IPv6 coverage

## Quick start

1. Install required collections:
   ```bash
   just install
   ```

2. Run:
   ```bash
   just run
   ```

## Key variables (`group_vars/alpine_gw/vars.yml`)

| Variable | Default | Description |
|---|---|---|
| `ssh_port` | `22` | SSH listen port |
| `http_port` | `80` | Inbound HTTP port |
| `https_port` | `443` | Inbound HTTPS port |

## Sensitive variables (`group_vars/alpine_gw/vault.yml`)

These live in the encrypted vault and are never committed in plain text:

| Variable | Description |
|---|---|
| `network_ipv4_address` / `network_ipv4_netmask` / `network_ipv4_gateway` | Static IPv4 config |
| `network_ipv6_address` / `network_ipv6_gateway` | Static IPv6 config |
| `ssh_allowed_ip` | Only IPv4 address allowed to connect via SSH |
| `caddy_acme_email` | Email for ACME/Let's Encrypt registration |
| `caddy_sites` | List of site entries — see below |

Each entry in `caddy_sites` supports:

| Field | Required | Description |
|---|---|---|
| `domain` | yes | Public domain name |
| `backend_host` | yes | Backend IP or hostname |
| `backend_port` | yes | Backend port |
| `csp` | no | Custom `Content-Security-Policy` header value |

## Dependencies

```bash
just install
```
