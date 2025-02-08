FROM python:3.13.1-slim-bookworm@sha256:031ebf3cde9f3719d2db385233bcb18df5162038e9cda20e64e08f49f4b47a2f AS install

SHELL ["/bin/bash", "-x", "-o", "pipefail", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

COPY requirements.txt .
RUN : \
    && pip install --no-cache-dir -r requirements.txt \
    && :

FROM install AS update
RUN : \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
         build-essential \
         git \
         ruby \
         ruby-dev \
    && :

RUN : \
    && apt-get update \
    && apt-get upgrade --yes \
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
