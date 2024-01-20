FROM python:3.11.7-slim-bookworm@sha256:d11b9bd5e49ea7401753d78f4d3b56f3aec952b85b49bcae88981f0452818e0b

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
