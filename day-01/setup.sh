#!/bin/bash

echo "🚀 DAY 1: Linux & Docker Setup"

# Verify Docker
echo "✅ Checking Docker..."
docker --version
docker ps

# Verify Git
echo "✅ Checking Git..."
git --version
git config --global user.email
git config --global user.name

# Create basic structure
echo "✅ Creating directory structure..."
mkdir -p services/{auth,product,order}
mkdir -p docker/{compose,scripts}
mkdir -p k8s/{base,overlays}
mkdir -p tests/{unit,integration}

# Display structure
echo ""
echo "📁 Project structure:"
tree -L 2 2>/dev/null || find . -type d | head -20

echo ""
echo "✅ DAY 1 Setup Complete!"
