FROM openstack/base
MAINTAINER Shuquan Huang

RUN apt-get update && apt-get install -y --no-install-recommends \
                   apache2 \
                   libapache2-mod-wsgi

RUN mkdir -p /opt/stack \
    && cd /opt/stack \
    && git clone https://git.openstack.org/openstack/keystone -b stable/newton

WORKDIR /opt/stack/keystone

RUN useradd --user-group keystone \
    && pip --no-cache-dir install . \
    && pip --no-cache-dir install pymysql \
    && mkdir -p /etc/keystone /var/www/cgi-bin/keystone /var/log/apache2 /home/keystone \
    && cp /usr/local/bin/keystone-wsgi-admin /var/www/cgi-bin/keystone/admin \
    && cp /usr/local/bin/keystone-wsgi-public /var/www/cgi-bin/keystone/main \
    && chown -R keystone: /etc/keystone /var/www/cgi-bin/keystone /var/log/apache2 /home/keystone

COPY wsgi-keystone.conf /etc/apache2/sites-available/wsgi-keystone.conf

RUN chown -R keystone: /var/www/cgi-bin/keystone \
    && ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled \
    && chmod 755 /var/www/cgi-bin/keystone/*

CMD /usr/local/bin/keystone-manage db_sync \
    && /usr/local/bin/keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone \
    && /usr/sbin/apache2ctl -D FOREGROUND
