#!/bin/bash

GITHUB_COMMIT_HASH=$(git rev-parse --short HEAD)

DOCKER_IMAGE_TAG="${GITHUB_COMMIT_HASH},latest"

aws ecr get-login-password --region ap-south-1 --profile satyam | docker login --username AWS --password-stdin 637423557273.dkr.ecr.ap-south-1.amazonaws.com
docker build -t "${DOCKER_IMAGE_TAG}" .
docker tag "${DOCKER_IMAGE_TAG}" 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH
docker push 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH



