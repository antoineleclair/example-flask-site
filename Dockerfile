FROM python:3.12.1
WORKDIR /code
COPY requirements.txt /code/requirements.txt
RUN pip install -r requirements.txt
COPY . /code/.
RUN echo "Pausing the build for 10 seconds..." && \
    sleep 10 && \
    echo "Resuming build."
CMD ["python", "server.py"]
