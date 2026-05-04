#!/bin/bash

echo "🐛 DOCKER DEBUGGING TOOLS"
echo "======================================"
echo ""

# Usage
if [ -z "$1" ]; then
    echo "Usage: bash debug.sh <service-name>"
    echo ""
    echo "Available services:"
    docker-compose ps --services
    echo ""
    echo "Examples:"
    echo "  bash debug.sh auth-service"
    echo "  bash debug.sh product-service"
    echo "  bash debug.sh order-service"
    exit 1
fi

SERVICE="$1"
CONTAINER_ID=$(docker-compose ps -q "$SERVICE" 2>/dev/null)

if [ -z "$CONTAINER_ID" ]; then
    echo "❌ Service '$SERVICE' not found or not running"
    exit 1
fi

echo "🔍 Debugging: $SERVICE"
echo "Container ID: $CONTAINER_ID"
echo ""

# 1. Show status
echo "1️⃣ CONTAINER STATUS:"
echo "===================="
docker ps -f id="$CONTAINER_ID" --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
echo ""

# 2. Show logs
echo "2️⃣ RECENT LOGS (last 20 lines):"
echo "================================"
docker logs --tail 20 "$CONTAINER_ID"
echo ""

# 3. Show environment
echo "3️⃣ ENVIRONMENT VARIABLES:"
echo "========================="
docker exec "$CONTAINER_ID" env | sort
echo ""

# 4. Show resource usage
echo "4️⃣ RESOURCE USAGE:"
echo "=================="
docker stats --no-stream "$CONTAINER_ID" | tail -1
echo ""

# 5. Show network
echo "5️⃣ NETWORK INFO:"
echo "================"
docker inspect "$CONTAINER_ID" --format '{{.NetworkSettings.Networks}}'
echo ""

# 6. Show health status
echo "6️⃣ HEALTH STATUS:"
echo "================="
HEALTH=$(docker inspect "$CONTAINER_ID" --format '{{.State.Health.Status}}' 2>/dev/null)
if [ -z "$HEALTH" ]; then
    echo "   No health check configured"
else
    echo "   Health: $HEALTH"
fi
echo ""

# 7. Show open ports
echo "7️⃣ OPEN PORTS:"
echo "=============="
docker port "$CONTAINER_ID"
echo ""

# 8. Interactive shell option
echo "📝 To enter container shell:"
echo "   docker-compose exec $SERVICE sh"
echo ""
