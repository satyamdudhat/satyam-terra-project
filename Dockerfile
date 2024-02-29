# # FROM public.ecr.aws/lambda/python:3.8
# FROM python:3.6-alpine
# # RUN /bin/bash -c apt-get update && apt-get install -y python3-pip

# # RUN apt-get update
# # RUN apt-get install -y python3-pip
# RUN apk add --no-cache python3 py3-pip
# COPY requirements.txt ./
# RUN pip install -r requirements.txt
# COPY myfunction.py ./

# CMD ["myfunction.lambda_handler"]


FROM public.ecr.aws/lambda/python:3.8

COPY myfunction.py .

RUN pip install boto3

CMD ["myfunction.lambda_handler"]





