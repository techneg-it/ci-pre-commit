FROM python:3.13.3-slim-bookworm@sha256:56a11364ffe0fee3bd60af6d6d5209eba8a99c2c16dc4c7c5861dc06261503cc AS install

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
