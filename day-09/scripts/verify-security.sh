#!/bin/bash

echo "🔒 DOCKERFILE SECURITY VERIFICATION"
echo "===================================="
echo ""

# Build images
echo "🔨 Building secure images..."
docker-compose build --quiet 2>/dev/null

echo "✅ Images built"
echo ""

# 1. Check if running as non-root
echo "1️⃣ Checking if container runs as non-root user..."
echo ""

echo "Auth Service:"
RESULT=$(docker run --rm auth-day09:latest whoami 2>/dev/null)
if [ "$RESULT" = "appuser" ]; then
    echo "   ✅ Running as: $RESULT (uid 1000)"
else
    echo "   ❌ Running as: $RESULT (should be appuser)"
fi

echo ""
echo "Product Service:"
RESULT=$(docker run --rm product-day09:latest whoami 2>/dev/null)
if [ "$RESULT" = "appuser" ]; then
    echo "   ✅ Running as: $RESULT (uid 1000)"
else
    echo "   ❌ Running as: $RESULT (should be appuser)"
fi

echo ""
echo "Order Service:"
RESULT=$(docker run --rm order-day09:latest id 2>/dev/null | grep uid=1000)
if [ ! -z "$RESULT" ]; then
    echo "   ✅ Running as: $RESULT"
else
    echo "   ❌ Not running as uid 1000"
fi

# 2. Check image metadata
echo ""
echo "2️⃣ Checking image labels..."
echo ""

echo "Auth labels:"
docker inspect auth-day09:latest | grep -A 5 "Labels" | head -7

# 3. Check file ownership
echo ""
echo "3️⃣ Checking file ownership..."
echo ""

echo "Auth Service files:"
docker run --rm auth-day09:latest ls -la /app | head -3

# 4. Health check validation
echo ""
echo "4️⃣ Testing health checks..."
echo ""

docker-compose up -d
sleep 5

echo "Auth health:"
curl -s http://localhost:3001/health | grep healthy && echo "   ✅ Healthy" || echo "   ❌ Not healthy"

echo "Product health:"
curl -s http://localhost:3002/health | grep healthy && echo "   ✅ Healthy" || echo "   ❌ Not healthy"

echo "Order health:"
curl -s http://localhost:3003/health | grep healthy && echo "   ✅ Healthy" || echo "   ❌ Not healthy"

docker-compose down

echo ""
echo "✅ Security verification complete!"
