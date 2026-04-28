# DAY 7: Docker Volumes & Persistence

## 🎯 Cele:
- Named volumes (PostgreSQL, Redis)
- Bind mounts (config files)
- Data persistence
- Backup & restore

## 📦 Volumes:
- `postgres_data` → Database files
- `redis_data` → Redis persistence
- `nginx_logs` → Nginx logs

## 🚀 Jak odpalić:

```bash
cd day-07
docker-compose build
docker-compose up -d
bash scripts/test-persistence.sh
