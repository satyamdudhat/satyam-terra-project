#!/bin/bash

GITHUB_COMMIT_HASH=$(git rev-parse --short HEAD)
AWS_ACCOUNT_ID="${AWS_ACCOUNT_ID}"
AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION}"
AWS_PROFILE="${AWS_PROFILE}"

aws ecr get-login-password --region $AWS_DEFAULT_REGION --profile $AWS_PROFILE | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
docker build -t satyam_fucntion1 .
docker tag satyam_fucntion1 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest
docker push 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest

docker tag satyam_fucntion1 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH
docker push 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH
