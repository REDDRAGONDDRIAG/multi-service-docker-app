#!/bin/bash

echo "🔧 TROUBLESHOOTING GUIDE"
echo "========================================"
echo ""

echo "1️⃣ CHECK OVERALL STATUS:"
echo "========================"
docker-compose ps
echo ""

echo "2️⃣ CHECK NETWORK:"
echo "================="
docker network ls | grep day10
docker network inspect day10_devops-network --format "{{json .Containers}}" | python3 -m json.tool 2>/dev/null || echo "Network info unavailable"
echo ""

echo "3️⃣ CHECK SERVICE LOGS:"
echo "====================="
for service in postgres redis auth-service product-service order-service; do
    echo "Checking $service..."
    docker-compose logs "$service" --tail 3
    echo ""
done

echo "4️⃣ CHECK CONNECTIVITY:"
echo "====================="

echo "Testing auth service can reach postgres:"
docker-compose exec -T auth-service sh -c 'ping -c 1 postgres' 2>/dev/null && echo "✅ Can reach postgres" || echo "❌ Cannot reach postgres"

echo "Testing product service can reach redis:"
docker-compose exec -T product-service sh -c 'ping -c 1 redis' 2>/dev/null && echo "✅ Can reach redis" || echo "❌ Cannot reach redis"

echo ""
echo "5️⃣ HEALTH CHECK STATUS:"
echo "======================="
docker ps --filter "health=healthy" --format "table {{.Names}}\t{{.Status}}"
echo ""

echo "6️⃣ TEST ENDPOINTS:"
echo "=================="
echo "Testing auth (3001):"
curl -s http://localhost:3001/health | grep -o '"status":"[^"]*"' || echo "❌ Not responding"

echo "Testing product (3002):"
curl -s http://localhost:3002/health | grep -o '"status":"[^"]*"' || echo "❌ Not responding"

echo "Testing order (3003):"
curl -s http://localhost:3003/health | grep -o '"status":"[^"]*"' || echo "❌ Not responding"

echo ""
echo "✅ Troubleshooting complete"
