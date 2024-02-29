FROM python:3.8-slim

COPY requirements.txt ./
RUN pip3 install -r requirements.txt
COPY myfunction.py ./

CMD ["myfunction.lambda_handler"]
