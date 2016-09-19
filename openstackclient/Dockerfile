FROM openstack/base
MAINTAINER Shuquan Huang

RUN apt-get update && pip install python-openstackclient

WORKDIR /root

COPY bootstrap.sh bootstrap.sh
COPY *-openrc ./

RUN wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img

RUN apt-get update && apt-get install -y supervisor \
                   && mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD /usr/bin/supervisord
