FROM python:3.12-alpine

WORKDIR /app

ENV COLOR=blue

COPY server.py .

EXPOSE 8080

CMD ["python", "server.py"]
