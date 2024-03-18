#!/bin/bash

GITHUB_COMMIT_HASH=$(git rev-parse --short HEAD)

aws ecr get-login-password --region "${AWS_DEFAULT_REGION}" --profile "${AWS_ACCOUNT_PROFILE}" | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com
docker build -t satyam_fucntion1 .
docker tag satyam_fucntion1 "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/satyam_project:latest
docker push "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/satyam_project:latest

docker tag satyam_fucntion1 "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH
docker push "${AWS_ACCOUNT_ID}".dkr.ecr."${AWS_DEFAULT_REGION}".amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH




