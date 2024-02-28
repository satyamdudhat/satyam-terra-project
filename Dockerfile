FROM ubuntu:20.04
# FROM public.ecr.aws/lambda/python:3.8

FROM python:3.9-slim-arm64

# COPY requirements.txt ./
# RUN pip3 install -r requirements.txt
COPY requirements.txt ./
RUN bash -c "pip3 install -r requirements.txt"

COPY myfunction.py ./

CMD ["myfunction.lambda_handler"]
