# DAY 9: Dockerfile Security Best Practices

## 1. Non-Root User

### Why?
- Prevents privilege escalation
- If container is compromised, attacker has limited access
- Industry standard practice

### How?

```dockerfile
# Create user
RUN addgroup -g 1000 appgroup && \
    adduser -D -u 1000 -G appgroup appuser

# Fix ownership
RUN chown -R appuser:appgroup /app

# Switch to user
USER appuser
