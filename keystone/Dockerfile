FROM openstack/base
MAINTAINER Shuquan Huang

RUN apt-get update && apt-get install -y --no-install-recommends \
                   apache2 \
                   libapache2-mod-wsgi

RUN mkdir -p /opt/stack \
    && cd /opt/stack \
    && git clone https://git.openstack.org/openstack/keystone

WORKDIR /opt/stack/keystone

RUN pip install .
