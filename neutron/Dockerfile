FROM openstack/base
MAINTAINER Shuquan Huang

# neutron-base
RUN apt-get update && apt-get -y install --no-install-recommends \
                   iputils-arping \
                   conntrack \
                   dnsmasq \
                   dnsmasq-utils \
                   ipset \
                   iptables \
                   openvswitch-switch \
                   python-openvswitch \
                   uuid-runtime

# neutron-l3-agent
RUN apt-get update && apt-get -y install --no-install-recommends \
                   keepalived

RUN mkdir -p /opt/stack \
    && cd /opt/stack \
    && git clone https://git.openstack.org/openstack/neutron

WORKDIR /opt/stack/neutron

RUN pip install .
