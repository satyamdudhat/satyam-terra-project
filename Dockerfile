# FROM python:3.8-slim

# COPY requirements.txt ./
# RUN pip install -r requirements.txt
# COPY myfunction.py ./

# CMD ["myfunction.lambda_handler"]


FROM python:3.8-slim

# Create a directory for dependencies
WORKDIR /app

# Copy requirements file
COPY requirements.txt ./

# Install dependencies using pip
RUN pip install -r requirements.txt

# Copy your Python function file
COPY myfunction.py ./

# Set the working directory for the Lambda function
WORKDIR /app

# Set the entry point for the Lambda function
CMD ["myfunction.lambda_handler"]