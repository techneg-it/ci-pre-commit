FROM python:3.12.4-slim-bookworm@sha256:bf20beb349a2762d6adccf370eaa4ff40bc367a4c7fe563110e08f0dbd7eaa2e

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
