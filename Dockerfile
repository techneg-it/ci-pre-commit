FROM python:3.12.4-slim-bookworm@sha256:e3ae8cf03c4f0abbfef13a8147478a7cd92798a94fa729a36a185d9106cbae32

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
