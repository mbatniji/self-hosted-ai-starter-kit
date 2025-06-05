#!/bin/bash

echo "🔄 Checking for code updates from GitHub..."
GIT_OUTPUT=$(git pull --quiet)
echo "$GIT_OUTPUT"

if [[ "$GIT_OUTPUT" == "Already up to date." || -z "$GIT_OUTPUT" ]]; then
  echo "✅ No new updates found. Skipping Docker image pull."
else
  echo "📦 Updates found. Pulling latest Docker images..."
  docker-compose pull
fi

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
