#!/bin/bash

BACKUP_DIR="./backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p $BACKUP_DIR

echo "💾 Backing up database..."
docker-compose exec -T postgres pg_dump -U devops devops_db > \
  $BACKUP_DIR/devops_db_$TIMESTAMP.sql

echo "✅ Backup saved: $BACKUP_DIR/devops_db_$TIMESTAMP.sql"
ls -lh $BACKUP_DIR/
