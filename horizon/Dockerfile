FROM openstack/base
MAINTAINER Shuquan Huang

RUN apt-get update && apt-get install -y --no-install-recommends \
                   gettext \
                   apache2 \
                   libapache2-mod-wsgi

RUN mkdir -p /opt/stack \
    && cd /opt/stack \
    && git clone https://github.com/openstack/horizon.git

WORKDIR /opt/stack/horizon

RUN useradd --user-group horizon \
    && mkdir -p /etc/openstack-dashboard /home/horizon \
    && ./run_tests.sh -q --compilemessages \
	&& pip --no-cache-dir install . \
    && pip --no-cache-dir install python-memcached

RUN	./manage.py collectstatic --noinput --clear \
	&& ./manage.py compress --force \
    && ./manage.py make_web_conf --wsgi \
    && ./manage.py make_web_conf --apache > /etc/apache2/sites-available/horizon.conf \
	&& a2ensite horizon

CMD cp /etc/openstack-dashboard/local_settings.py openstack_dashboard/local/local_settings.py \
    && ./run_tests.sh --runserver 0.0.0.0:80
