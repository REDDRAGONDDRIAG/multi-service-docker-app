#!/bin/bash

echo "🚀 DEPLOYING TO KUBERNETES"
echo "===================================="
echo ""

# Check if Minikube is running
echo "1️⃣ Checking Minikube..."
minikube status > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "⚠️ Minikube not running, starting..."
    minikube start --driver=docker --cpus=4 --memory=6144
fi
echo "✅ Minikube is running"
echo ""

# Enable ingress addon
echo "2️⃣ Enabling Ingress addon..."
minikube addons enable ingress > /dev/null 2>&1
echo "✅ Ingress enabled"
echo ""

# Setup Docker environment
echo "3️⃣ Setting Docker environment..."
eval $(minikube docker-env)
echo "✅ Docker environment set"
echo ""

# Build images
echo "4️⃣ Building Docker images..."
docker build -f ../day-09/services/auth-service-secure/Dockerfile.secure \
  -t auth-service:1.0 \
  ../day-09/services/auth-service-secure/

docker build -f ../day-09/services/product-service-secure/Dockerfile.secure \
  -t product-service:1.0 \
  ../day-09/services/product-service-secure/

docker build -f ../day-09/services/order-service-secure/Dockerfile.secure \
  -t order-service:1.0 \
  ../day-09/services/order-service-secure/
echo "✅ Docker images built"
echo ""

# Deploy
echo "5️⃣ Deploying to Kubernetes..."
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/postgres.yaml
kubectl apply -f k8s/redis.yaml

# Wait for postgres
echo "   Waiting for PostgreSQL..."
kubectl wait --for=condition=ready pod -l app=postgres -n devops-app --timeout=300s 2>/dev/null
echo "   ✅ PostgreSQL ready"

# Deploy services
kubectl apply -f k8s/services.yaml
kubectl apply -f k8s/ingress.yaml
echo "✅ Services deployed"
echo ""

# Get status
echo "6️⃣ Deployment Status:"
echo "===================="
kubectl get all -n devops-app
echo ""

# Get ingress
echo "7️⃣ Ingress Configuration:"
echo "======================"
kubectl get ingress -n devops-app
echo ""

# Port forward option
echo "8️⃣ Access Services:"
echo "=================="
echo "Option 1 - Port forward (use in separate terminal):"
echo "  kubectl port-forward svc/auth-service 3001:3001 -n devops-app"
echo "  kubectl port-forward svc/product-service 3002:3002 -n devops-app"
echo "  kubectl port-forward svc/order-service 3003:3003 -n devops-app"
echo ""
echo "Option 2 - Through Minikube service:"
echo "  minikube service auth-service -n devops-app"
echo ""

echo "✅ Deployment complete!"
echo ""
echo "🧪 Test:"
echo "======="
echo "kubectl get pods -n devops-app"
echo "kubectl logs <pod-name> -n devops-app"
echo "kubectl exec -it <pod-name> -n devops-app -- sh"
