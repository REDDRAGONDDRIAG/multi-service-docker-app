#!/bin/bash

echo "🧪 Testing Data Persistence"

# Create test data
docker-compose exec -T postgres psql -U devops -d devops_db -c \
  "INSERT INTO users (username, email, password_hash) VALUES ('testuser', 'test@example.com', 'hash123');"

echo "✅ Data created"

# Stop and restart
docker-compose stop
sleep 3
docker-compose start
sleep 5

# Check if data persists
echo "Checking if data persists after restart..."
docker-compose exec -T postgres psql -U devops -d devops_db -c "SELECT * FROM users;" | grep testuser && \
  echo "✅ PERSISTENCE WORKS!" || echo "❌ Data lost"
