FROM python:latest
ADD requirement.txt /
RUN pip install -r /requirement.txt
ADD app /app
ENTRYPOINT ["python", "/app/main.py"]
