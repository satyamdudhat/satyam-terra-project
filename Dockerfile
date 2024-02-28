FROM python:3.9-slim-arm64

COPY requirements.txt ./
RUN pip3 install -r requirements.txt
COPY myfunction.py ./

CMD ["myfunction.lambda_handler"]
