#!/bin/bash

echo "🔄 Pulling latest code from GitHub..."
git pull

echo "📦 Pulling latest Docker images..."
docker-compose pull

echo "🧹 Stopping current containers..."
docker-compose down

echo "🚀 Starting containers with profile [cpu]..."
docker-compose --profile cpu up -d

echo "✅ All done. Running containers:"
docker ps
