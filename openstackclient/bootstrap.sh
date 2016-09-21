#!/bin/bash

set -x

USERNAME=$1
PASSWORD=password
PROJECT=$3
ROLE=$4
KEYSTONE_ADMIN_URL=http://keystone:35357/v3
KEYSTONE_INTERNAL_URL=http://keystone:5000/v3
KEYSTONE_PUBLIC_URL=http://keystone:5000/v3
GLANCE_ADMIN_URL=http://glance:9292
GLANCE_INTERNAL_URL=http://glance:9292
GLANCE_PUBLIC_URL=http://glance:9292
NOVA_ADMIN_URL=http://nova:8774/v2.1/%\(tenant_id\)s
NOVA_INTERNAL_URL=http://nova:8774/v2.1/%\(tenant_id\)s
NOVA_PUBLIC_URL=http://nova:8774/v2.1/%\(tenant_id\)s
NEUTRON_ADMIN_URL=http://neutron:9696
NEUTRON_INTERNAL_URL=http://neutron:9696
NEUTRON_PUBLIC_URL=http://neutron:9696
REGION=RegionOne

export OS_TOKEN=ADMIN_TOKEN
export OS_URL=$KEYSTONE_ADMIN_URL
export OS_IDENTITY_API_VERSION=3

# Create the service entity and API endpoints
openstack service create \
--name keystone --description "OpenStack Identity" identity

openstack endpoint create --region $REGION \
identity public $KEYSTONE_PUBLIC_URL

openstack endpoint create --region $REGION \
identity internal $KEYSTONE_INTERNAL_URL

openstack endpoint create --region $REGION \
identity admin $KEYSTONE_ADMIN_URL

# Create a domain, projects, users, and roles
# Create the default domain
openstack domain create --description "Default Domain" default

# Create the admin project
openstack project create --domain default \
--description "Admin Project" admin

# Create the admin user
openstack user create --domain default \
--password $PASSWORD admin

# Create the admin role
openstack role create admin

# Add the admin role to the admin project and user
openstack role add --project admin --user admin admin

# Create the service project
openstack project create --domain default \
--description "Service Project" service

# Create the demo project
openstack project create --domain default \
--description "Demo Project" demo

# Create the demo user
openstack user create --domain default \
--password $PASSWORD demo

# Create the user role
openstack role create user

# Add the user role to the demo project and user
openstack role add --project demo --user demo user

# Create the glance user
openstack user create --domain default --password $PASSWORD glance

openstack role add --project service --user glance admin

# Create the glance service entity
openstack service create --name glance \
--description "OpenStack Image" image

# Create the Image service API endpoints
openstack endpoint create --region RegionOne \
image public $GLANCE_PUBLIC_URL

openstack endpoint create --region RegionOne \
image internal $GLANCE_INTERNAL_URL

openstack endpoint create --region RegionOne \
image admin $GLANCE_ADMIN_URL

# Create the nova user
openstack user create --domain default \
--password $PASSWORD nova

# Add the admin role to the nova user
openstack role add --project service --user nova admin

# Create the nova service entity
openstack service create --name nova \
--description "OpenStack Compute" compute

# Create the Compute service API endpoints
openstack endpoint create --region RegionOne \
compute public $NOVA_PUBLIC_URL

openstack endpoint create --region RegionOne \
compute internal $NOVA_INTERNAL_URL

openstack endpoint create --region RegionOne \
compute admin $NOVA_ADMIN_URL

# Create the neutron user
openstack user create --domain default --password $PASSWORD neutron

# Add the admin role to the neutron user
openstack role add --project service --user neutron admin

# Create the neutron service entity
openstack service create --name neutron \
--description "OpenStack Networking" network

# Create the Networking service API endpoints
openstack endpoint create --region RegionOne \
network public $NEUTRON_PUBLIC_URL

openstack endpoint create --region RegionOne \
network internal $NEUTRON_INTERNAL_URL

openstack endpoint create --region RegionOne \
network admin $NEUTRON_ADMIN_URL

unset OS_TOKEN OS_URL

set +x
