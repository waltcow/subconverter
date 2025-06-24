#!/bin/bash

# Build script for local subconverter Docker image
# Usage: ./build_local_docker.sh [tag] [threads]

# Default values
DEFAULT_TAG="subconverter:local"
DEFAULT_THREADS="4"

# Parse arguments
TAG=${1:-$DEFAULT_TAG}
THREADS=${2:-$DEFAULT_THREADS}
SHA=$(git rev-parse --short HEAD 2>/dev/null || echo "")

echo "Building subconverter Docker image..."
echo "Tag: $TAG"
echo "Threads: $THREADS"
echo "SHA: $SHA"
echo ""

# Build the Docker image
docker build \
    --build-arg THREADS="$THREADS" \
    --build-arg SHA="$SHA" \
    -f scripts/Dockerfile.custom \
    -t "$TAG" \
    .

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build completed successfully!"
    echo "Image tagged as: $TAG"
    echo ""
    echo "To run the container:"
    echo "docker run -d -p 25500:25500 --name subconverter $TAG"
else
    echo ""
    echo "❌ Build failed!"
    exit 1
fi
