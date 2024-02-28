# FROM ubuntu:20.04

# FROM public.ecr.aws/lambda/python:3.8

# COPY requirements.txt ./
# RUN pip3 install -r requirements.txt

# COPY myfunction.py ./

# CMD ["myfunction.lambda_handler"]
# Use a base image compatible with ARM architecture
FROM python:3.8

# Copy requirements file and install dependencies
COPY requirements.txt ./
RUN pip3 install -r requirements.txt

# Copy your Python function code
COPY myfunction.py ./

# Specify the command to run your function
CMD ["myfunction.lambda_handler"]
