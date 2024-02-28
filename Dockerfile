FROM public.ecr.aws/lambda/python:3.8

COPY requirements.txt ./
COPY myfunction.py ./

RUN pip3 install -r requirements.txt
CMD ["myfunction.lambda_handler"]
