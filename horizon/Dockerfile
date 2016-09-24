FROM openstack/base
MAINTAINER Shuquan Huang

RUN apt-get update && apt-get install -y --no-install-recommends \
                   openstack-dashboard

CMD /usr/sbin/apache2ctl -D FOREGROUND
