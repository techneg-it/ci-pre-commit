FROM python:3.11.7-slim-bookworm@sha256:110609b2b904da7fb1226a92b6c02af5d6d599c5993f6194d1366d0d6a8a8295

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
