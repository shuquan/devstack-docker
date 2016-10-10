FROM openstack/base
MAINTAINER Shuquan Huang

RUN apt-get update && pip install python-openstackclient \
                   && pip install python-neutronclient

WORKDIR /root

RUN wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img

COPY *.sh ./
COPY *-openrc ./

RUN apt-get update && apt-get install -y supervisor \
                   && mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD /usr/bin/supervisord
