FROM openstack/base
MAINTAINER Shuquan Huang

# cinder-base
RUN apt-get update && apt-get install -y --no-install-recommends \
#                   lvm \
                   qemu-utils

# cinder-rpcbind
RUN apt-get update && apt-get install -y --no-install-recommends \
                   rpcbind

# cinder-volume
RUN apt-get update && apt-get install -y --no-install-recommends \
                   tgt

RUN mkdir -p /opt/stack \
    && cd /opt/stack \
    && git clone https://git.openstack.org/openstack/cinder -b stable/newton

WORKDIR /opt/stack/cinder

RUN pip install .
