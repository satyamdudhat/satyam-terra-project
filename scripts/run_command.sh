#!/bin/bash

GITHUB_COMMIT_HASH=$(git rev-parse --short HEAD)
# ACCOUNT_ID=637423557273
IMAGE_NAME="satyam_fucntion1"

# DOCKER_IMAGE_TAG="${GITHUB_COMMIT_HASH}"

aws ecr get-login-password --region ap-south-1 --profile satyam | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com
docker build -t $IMAGE_NAME .
docker tag $IMAGE_NAME $AWS_ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest

docker tag $IMAGE_NAME $AWS_ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH
docker push $AWS_ACCOUNT_ID.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH



