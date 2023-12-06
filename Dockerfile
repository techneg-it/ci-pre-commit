FROM python:3.11.7-slim-bookworm

ENV version=3.5.0

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential git ruby ruby-dev && \
    pip install --no-cache-dir pre-commit==$version && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT []
CMD []
WORKDIR /work

LABEL name=pre-commit version=$version \
      maintainer="Dafydd Jones <dafydd@techneg.it>"
