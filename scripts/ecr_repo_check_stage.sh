#!/bin/bash

if aws ecr describe-repositories --repository-names "project_stage" --profile "${AWS_PROFILE}" &> /dev/null; then
    echo "ECR repository exists"
    echo "::set-output name=exists::true"
else
    terraform plan
    terraform apply -auto-approve -target=module.ecr_repo
fi