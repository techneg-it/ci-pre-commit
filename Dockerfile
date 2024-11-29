FROM python:3.13.0-slim-bookworm@sha256:4efa69bf17cfbd83a9942e60e2642335c3b397448e00410063a0421f9727c4c4

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
    && sed -i "/# If not running interactively,/i export CI_CACHE_ID=\"$CI_CACHE_ID\"\n" /etc/bash.bashrc \
    && :

ENTRYPOINT []
CMD []
WORKDIR /work
