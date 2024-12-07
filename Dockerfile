FROM python:3.13.0-slim-bookworm@sha256:0de818129b26ed8f46fd772f540c80e277b67a28229531a1ba0fdacfaed19bcb

SHELL ["/bin/bash", "-x", "-o", "pipefail", "-c"]

COPY requirements.txt .
RUN : \
    && pip install --no-cache-dir -r requirements.txt \
    && :

RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
         build-essential \
         git \
         ruby \
         ruby-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && :

RUN : \
    && ARCH=$(uname -m) \
    && PRECOMMIT_VERSION=$(pre-commit -V | awk '{print $2}' | awk -F. '{print $1}') \
    && RUBY_VERSION=$(ruby -v | awk '{print $2}' | awk -F. '{print $1 "." $2}') \
    && CI_CACHE_ID="pre-commit|$ARCH|$PRECOMMIT_VERSION|$PYTHON_VERSION|$RUBY_VERSION" \
    && echo "$CI_CACHE_ID" > /.ci_cache_id \
    && :

ENTRYPOINT []
CMD []
WORKDIR /work
