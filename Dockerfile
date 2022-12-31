ARG python_version=3.8.14

FROM python:${python_version}-bullseye

# system packages
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install -y \
    gnupg2 \
    python3-pip \
    sshpass \
    git \
    curl \
    openssh-client && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean

WORKDIR /home/fsct

ADD . ./FSCT

## add fsct user
ENV PATH="${PATH}:/home/fsct/.local/bin:/home/fsct/bin"
RUN \
  useradd --shell /bin/bash -u 1000 -o -c "" -m fsct && \
  chown -R fsct:fsct /home/fsct

USER fsct

RUN \
  cd ./FSCT && \
  pip install --user -r requirements.txt
