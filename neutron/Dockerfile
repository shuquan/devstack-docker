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

CMD /usr/local/bin/neutron-db-manage --config-file /etc/neutron/neutron.conf \
    --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head \
    &&/usr/bin/supervisord
