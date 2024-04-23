#!/bin/bash

if aws ecr describe-repositories --repository-names "satyam_project" --profile "${AWS_PROFILE}" &> /dev/null; then
    echo "ECR repository exists"
    echo "::set-output name=exists::true"
else
    terraform init
    terraform apply -auto-approve -target=aws_ecr_repository.satyam_project
fi