FROM python:3.12.4-slim-bookworm@sha256:740d94a19218c8dd584b92f804b1158f85b0d241e5215ea26ed2dcade2b9d138

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
