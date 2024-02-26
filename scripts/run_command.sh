#!/bin/bash

aws ecr get-login-password --region us-west-2 --profile sandbox | docker login --username AWS --password-stdin 843728461002.dkr.ecr.us-west-2.amazonaws.com
docker build -t satyam_project --platform linux/arm64 .
docker tag b8a0cb76fcd2 843728461002.dkr.ecr.us-west-2.amazonaws.com/satyam_project:latest
docker push 843728461002.dkr.ecr.us-west-2.amazonaws.com/satyam_project:latest