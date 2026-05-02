# DAY 9: Dockerfile Security Best Practices

## 🎯 Cele:
- Non-root users (uid 1000)
- Specific version tags
- Health checks
- Security labels
- Read-only filesystem
- No new privileges

## 🔒 Security Features:

```yaml
# docker-compose.yml
security_opt:
  - no-new-privileges:true
read_only: true
tmpfs:
  - /tmp
  - /run
