FROM python:latest
ADD requirement.txt /
RUN pip install -r /requirement.txt
ADD app /app
<<<<<<< HEAD
ENTRYPOINT ["python", "/app/main.py"]
=======
CMD python /app/main.py
>>>>>>> f6ddf2c3713ab718548f196dc10b33b05436a6c0
