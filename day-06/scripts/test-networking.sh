#!/bin/bash

echo "🧪 Testing Docker Networking"
echo ""

echo "1️⃣ Auth → Database:"
docker-compose exec -T auth-service sh -c 'ping -c 1 postgres 2>/dev/null' && echo "✅" || echo "❌"

echo "2️⃣ Product → Database:"
curl -s http://localhost:3002/health | grep healthy && echo "✅" || echo "❌"

echo "3️⃣ Order → Cache:"
docker-compose exec -T order-service sh -c 'ping -c 1 cache 2>/dev/null' && echo "✅" || echo "❌"

echo "4️⃣ Auth → Product (same network):"
docker-compose exec -T auth-service curl -s http://product-service:3002/health | grep healthy && echo "✅" || echo "❌"

echo "5️⃣ Nginx Routing:"
curl -s http://localhost/health | grep healthy && echo "✅" || echo "❌"

echo ""
echo "✅ All tests complete"
