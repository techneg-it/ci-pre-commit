FROM python:3.13.7-slim-bookworm@sha256:9b8102b7b3a61db24fe58f335b526173e5aeaaf7d13b2fbfb514e20f84f5e386 AS install

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
         time \
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
    && PY_MAJ_MIN_VERSION=$(echo $PYTHON_VERSION | awk -F. '{print $1 "." $2}') \
    && RUBY_VERSION=$(ruby -v | awk '{print $2}' | awk -F. '{print $1 "." $2}') \
    && CI_CACHE_ID="pre-commit|$ARCH|$PRECOMMIT_VERSION|$PY_MAJ_MIN_VERSION|$RUBY_VERSION" \
    && echo "$CI_CACHE_ID" > /.ci_cache_id \
    && :

ENTRYPOINT []
CMD []
WORKDIR /work
