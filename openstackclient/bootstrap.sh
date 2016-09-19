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
openstack user create --domain default --password password glance

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

unset OS_TOKEN OS_URL

set +x
