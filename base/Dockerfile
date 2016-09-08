FROM ubuntu:14.04
MAINTAINER Shuquan Huang

RUN apt-get update && apt-get install -y --no-install-recommends \
                   ca-certificates \
                   curl \
                   build-essential \
                   gawk \
                   python-dev \
                   libssl-dev \
                   libmariadbclient-dev \
                   libxslt1-dev \
                   libffi-dev \
                   libyaml-dev \
                   lvm2 \
                   open-iscsi \
                   pkg-config \
                   python \
                   git \
                   tgt \
                   wget \
                   unzip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py \
    && rm get-pip.py

