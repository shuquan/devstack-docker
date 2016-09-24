docker build -t openstack/base base
docker build -t openstack/openstackclient openstackclient
docker build -t openstack/keystone keystone
docker build -t openstack/glance glance
docker build -t openstack/nova nova
docker build -t openstack/neutron neutron
docker build -t openstack/cinder cinder
docker build -t openstack/horizon horizon
