FROM python:3.12.1
WORKDIR /code
COPY requirements.txt /code/requirements.txt
RUN pip install -r requirements.txt
COPY . /code/.
RUN --mount=type=secret,id=ACCESS_KEY \
    --mount=type=secret,id=ACCESS_TOKEN \
    cat /run/secrets/ACCESS_KEY
CMD ["python", "server.py"]