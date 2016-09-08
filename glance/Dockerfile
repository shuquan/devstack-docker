FROM openstack/base
MAINTAINER Shuquan Huang

RUN mkdir -p /opt/stack \
    && cd /opt/stack \
    && git clone https://git.openstack.org/openstack/glance

WORKDIR /opt/stack/glance

RUN pip install .
