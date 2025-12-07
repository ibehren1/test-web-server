#!/bin/bash

# Internal registry for publishing dev builds.
INTERNAL_REG="registry.internal.behrenshome.com"

DATE=`date +"%Y-%m-%d"`

#
# Set some colors.
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

#
# Determine which tag to apply to image.
if [ "${1}" == "Prod" ]; then
   BUILD_TYPE="Prod"
else
   BUILD_TYPE="Dev"
fi

# Set the Docker Hub username and password
docker login -u ${DOCKER_USER} -p ${DOCKER_PAT}

# Build images for ARM64 and AMD64.
docker buildx create \
    --use \
    --platform=linux/arm64,linux/amd64 \
    --name multi-platform-builder

docker buildx inspect \
    --bootstrap

if [ "${BUILD_TYPE}" == "Dev" ]; then
    docker buildx build -f Dockerfile \
        --platform=linux/arm64,linux/amd64 \
        --no-cache \
        --push \
        --tag ${INTERNAL_REG}/test-web-server:dev-v${DATE} \
        --tag ${INTERNAL_REG}/test-web-server:dev-latest .
fi

if [ "${BUILD_TYPE}" == "Prod" ]; then
    docker buildx build -f Dockerfile \
        --platform=linux/arm64,linux/amd64 \
        --no-cache \
        --push \
        --tag ${INTERNAL_REG}/test-web-server:v${DATE} \
        --tag ${INTERNAL_REG}/test-web-server:latest \
        --tag ${DOCKER_USER}/test-web-server:v${DATE} \
        --tag ${DOCKER_USER}/test-web-server:latest .
fi

echo -e "\n${GREEN}${BUILD_TYPE} Build of v${DATE} completed.${NC}"

exit 0
