FROM python:3.11.7-slim-bookworm@sha256:04db1f35625d657b1ed501a5da26854d057949d2e0003c1ea506f82968fbd7bd

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential git ruby ruby-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT []
CMD []
WORKDIR /work

LABEL name=pre-commit \
      maintainer="Dafydd Jones <dafydd@techneg.it>"
