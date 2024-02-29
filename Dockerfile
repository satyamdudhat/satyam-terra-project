FROM public.ecr.aws/lambda/python:3.8

COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY myfunction.py ./

CMD ["myfunction.lambda_handler"]
