FROM python:3.12.1


ARG NODE_VERSION=22.14.0
ARG YARN_VERSION=1.22.22
ENV PYTHONUNBUFFERED=0
RUN apt-get update
RUN apt-get upgrade -yqq
RUN apt-get install -y gettext docker.io
RUN rm -rf /var/lib/apt/lists/*
WORKDIR /code
RUN NODE_VERSION="v$NODE_VERSION" \
  ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    arm64) ARCH='arm64';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && for key in $(curl -sL https://raw.githubusercontent.com/nodejs/docker-node/HEAD/keys/node.keys); do \
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key" || \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"; \
  done \
  && curl -fsSLO --compressed "https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-$ARCH.tar.xz" \
  && curl -fsSLO --compressed "https://nodejs.org/dist/$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

WORKDIR /code
COPY requirements.txt /code/requirements.txt
RUN pip install -r requirements.txt
COPY . /code/.
CMD ["python", "server.py"]