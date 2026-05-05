#!/bin/bash

echo "📊 SETTING UP MONITORING STACK"
echo "================================"
echo ""

# Build and start
echo "🔨 Building services..."
docker-compose build --quiet

echo "🚀 Starting services..."
docker-compose up -d

echo ""
echo "⏳ Waiting for services to start (30s)..."
sleep 30

echo ""
echo "✅ Services started!"
echo ""

# Check status
echo "📋 Service Status:"
docker-compose ps
echo ""

# Health checks
echo "🧪 Health Checks:"
echo "================="

echo "Auth Service:"
curl -s http://localhost:3001/health | grep -q "healthy" && echo "  ✅ Healthy" || echo "  ❌ Not responding"

echo "Product Service:"
curl -s http://localhost:3002/health | grep -q "healthy" && echo "  ✅ Healthy" || echo "  ❌ Not responding"

echo "Order Service:"
curl -s http://localhost:3003/health | grep -q "healthy" && echo "  ✅ Healthy" || echo "  ❌ Not responding"

echo ""
echo "📈 Monitoring URLs:"
echo "==================="
echo "Prometheus: http://localhost:9090"
echo "Grafana:    http://localhost:3000 (admin/admin123)"
echo ""

echo "📝 Next steps:"
echo "=============="
echo "1. Open Grafana: http://localhost:3000"
echo "2. Login: admin / admin123"
echo "3. Prometheus should be auto-added as datasource"
echo "4. Create dashboards using Prometheus queries"
echo ""

echo "✅ Setup complete!"
