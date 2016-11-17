FROM openstack/base
MAINTAINER Shuquan Huang

RUN mkdir -p /opt/stack \
    && cd /opt/stack \
    && git clone https://git.openstack.org/openstack/glance -b stable/newton

WORKDIR /opt/stack/glance

RUN useradd --user-group glance \
    && pip --no-cache-dir install . \ 
    && pip --no-cache-dir install pymysql \ 
    && mkdir -p /etc/glance /var/lib/glance /var/log/glance /home/glance \
    && chown -R glance: /etc/glance /var/lib/glance /var/log/glance /home/glance

RUN apt-get update && apt-get install -y supervisor \
                   && mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9292 9191

CMD /usr/local/bin/glance-manage db_sync \
    && /usr/bin/supervisord
