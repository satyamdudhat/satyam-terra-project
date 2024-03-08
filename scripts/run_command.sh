#!/bin/bash

# Get the current GitHub commit hash
GITHUB_COMMIT_HASH=$(git rev-parse --short HEAD)

# Docker image tag with GitHub commit hash
DOCKER_IMAGE_TAG="satyam-image:${GITHUB_COMMIT_HASH}"

# # Build the Docker image
# docker build -t "${DOCKER_IMAGE_TAG}" .

# # Push the Docker image to your Docker registry (e.g., Amazon ECR)
# docker push "${DOCKER_IMAGE_TAG}"



aws ecr get-login-password --region ap-south-1 --profile satyam | docker login --username AWS --password-stdin 637423557273.dkr.ecr.ap-south-1.amazonaws.com
docker build -t "${DOCKER_IMAGE_TAG}" .
docker tag "${DOCKER_IMAGE_TAG}" 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest
docker push 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest



