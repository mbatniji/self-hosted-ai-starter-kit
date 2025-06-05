#!/bin/bash

echo "🔄 Pulling latest code from GitHub..."
git pull

echo "📦 Pulling latest Docker images..."
docker-compose pull

echo "🧹 Stopping current containers..."
docker-compose down


echo "⬇️ Pulling required Ollama models (llama3, phi)..."
docker-compose --profile cpu up -d ollama-pull-llama3 ollama-pull-phi

echo "⏳ Waiting 30 seconds for model downloads to initialize..."
sleep 30

echo "🧼 Stopping model pull containers..."
docker-compose stop ollama-pull-llama3 ollama-pull-phi

echo "🚀 Starting all containers with profile [cpu]..."
docker-compose --profile cpu up -d

echo "✅ All done. Running containers:"
docker ps
