FROM openstack/base
MAINTAINER Shuquan Huang

RUN apt-get update && pip install python-openstackclient

COPY bootstrap.sh /root/bootstrap.sh
COPY *-openrc /root/
