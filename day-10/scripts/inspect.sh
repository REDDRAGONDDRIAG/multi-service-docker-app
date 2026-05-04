#!/bin/bash

echo "🔎 DETAILED CONTAINER INSPECTION"
echo "=================================="
echo ""

if [ -z "$1" ]; then
    echo "Usage: bash inspect.sh <service-name>"
    exit 1
fi

SERVICE="$1"
CONTAINER_ID=$(docker-compose ps -q "$SERVICE")

if [ -z "$CONTAINER_ID" ]; then
    echo "❌ Service '$SERVICE' not running"
    exit 1
fi

echo "Service: $SERVICE"
echo "Container ID: $CONTAINER_ID"
echo ""

# Full inspect output
docker inspect "$CONTAINER_ID" | python3 -m json.tool

echo ""
echo "✅ Full inspection dumped above"
