FROM python:3.8-slim-arm64

COPY requirements.txt ./
COPY myfunction.py ./

RUN echo "Listing files:" && ls -l  
RUN cat requirements.txt  


RUN pip3 install -r requirements.txt
CMD ["myfunction.lambda_handler"]
