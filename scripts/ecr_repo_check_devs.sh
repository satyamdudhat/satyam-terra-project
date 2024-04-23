#!/bin/bash

if aws ecr describe-repositories --repository-names "satyam_project_devs" --profile "${AWS_PROFILE}" &> /dev/null; then
    echo "ECR repository exists"
    echo "::set-output name=exists::true"
else
    terraform apply -auto-approve -target=modules.ECR.aws_ecr_repository.ecr_repo
fi