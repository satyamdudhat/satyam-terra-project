# FROM public.ecr.aws/lambda/python:3.8
FROM alpine:3.18
# RUN /bin/bash -c apt-get update && apt-get install -y python3-pip

COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY myfunction.py ./

CMD ["myfunction.lambda_handler"]
