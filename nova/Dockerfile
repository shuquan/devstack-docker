FROM openstack/base
MAINTAINER Shuquan Huang

# nova-base
RUN apt-get update && apt-get install -y --no-install-recommends \
                   iptables \
                   ebtables \
                   dnsmasq \
                   bridge-utils \
                   python-libvirt \
                   openssh-client \
                   openvswitch-switch

# nova-compute
RUN apt-get update && apt-get install -y --no-install-recommends \
                   libvirt-dev \
                   qemu-utils \
                   genisoimage \
                   open-iscsi \
                   targetcli \
                   python-rtslib

# nova-libvirt
RUN apt-get update && apt-get -y install --no-install-recommends \ 
                   libvirt-bin \
                   dmidecode \
                   pm-utils \
                   qemu \
                   ebtables

RUN mkdir -p /opt/stack \
    && cd /opt/stack \
    && git clone https://git.openstack.org/openstack/nova

RUN git clone https://github.com/kanaka/noVNC /usr/share/novnc

WORKDIR /opt/stack/nova

RUN useradd --user-group --create-home --home-dir /var/lib/nova nova \
    && chmod 755 /var/lib/nova \
    && pip --no-cache-dir install . \
    && pip --no-cache-dir install pymysql \
    && mkdir -p /etc/nova /var/lib/nova/instances \
    && chown -R nova: /etc/nova /var/lib/nova

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

RUN mkdir -p /opt/stack \
    && cd /opt/stack \
    && git clone https://git.openstack.org/openstack/neutron

WORKDIR /opt/stack/neutron

RUN useradd --user-group neutron \
    && pip --no-cache-dir install . \
    && pip --no-cache-dir install pymysql \
    && mkdir -p /etc/neutron /usr/share/neutron /var/lib/neutron /home/neutron \
    && chown -R neutron: /etc/neutron /usr/share/neutron /var/lib/neutron /home/neutron

# neutron-linuxbridge-agent
RUN apt-get update && apt-get -y install --no-install-recommends \
                   ebtables
# supervisor
RUN apt-get update && apt-get -y install --no-install-recommends supervisor \
                   && mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8774

CMD /usr/local/bin/nova-manage api_db sync \
    && /usr/local/bin/nova-manage db sync \
    && service libvirt-bin restart \
    && /usr/bin/supervisord
