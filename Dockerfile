FROM python:3.12.6-slim-bookworm@sha256:15bad989b293be1dd5eb26a87ecacadaee1559f98e29f02bf6d00c8d86129f39

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
