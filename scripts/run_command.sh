#!/bin/bash

GITHUB_COMMIT_HASH=$(git rev-parse --short HEAD)

aws ecr get-login-password --region ap-south-1 --profile satyam | docker login --username AWS --password-stdin 637423557273.dkr.ecr.ap-south-1.amazonaws.com
docker build -t satyam_fucntion1 .
docker tag satyam_fucntion1 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest
docker push 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:latest

docker tag satyam_fucntion1 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH
docker push 637423557273.dkr.ecr.ap-south-1.amazonaws.com/satyam_project:$GITHUB_COMMIT_HASH
