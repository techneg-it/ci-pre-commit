FROM python:3.12.5-slim-bookworm@sha256:59c7332a4a24373861c4a5f0eec2c92b87e3efeb8ddef011744ef9a751b1d11c

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
