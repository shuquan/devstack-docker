#!/bin/bash

set -x

# Create virtual networks
# Create the self-service network

. demo-openrc

neutron net-create selfservice

neutron subnet-create --name selfservice \
--dns-nameserver 8.8.4.4 --gateway 192.168.1.1 \
selfservice 192.168.1.0/24

# Create m1.nano flavor

. admin-openrc

openstack flavor create --id 0 --vcpus 1 --ram 64 --disk 1 m1.nano

# Upload the image to the Image service

openstack image create "cirros" \
--file cirros-0.3.4-x86_64-disk.img \
--disk-format qcow2 --container-format bare \
--public

# Launch an instance on the self-service network

. demo-openrc

SELFSERVICE_NET_ID=`openstack network list|awk '/selfservice/{print $2}'`

openstack server create --flavor m1.nano --image cirros \
--nic net-id=$SELFSERVICE_NET_ID selfservice-instance
