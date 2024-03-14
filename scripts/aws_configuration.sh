#!/bin/bash


aws configure set aws_access_key_id ${ secrets.AWS_ACCESS_KEY_ID } --profile satyam
aws configure set aws_secret_access_key ${ secrets.AWS_SECRET_ACCESS_KEY } --profile satyam
aws configure set region ${ secrets.AWS_DEFAULT_REGION } --profile satyam
