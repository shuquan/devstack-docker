#!/bin/bash

set -x

USERNAME=$1
PASSWORD=password
PROJECT=$3
ROLE=$4
ADMIN_URL=http://keystone:35357/v3
INTERNAL_URL=http://keystone:5000/v3
PUBLIC_URL=http://keystone:5000/v3
REGION=RegionOne

export OS_TOKEN=ADMIN_TOKEN
export OS_URL=$ADMIN_URL
export OS_IDENTITY_API_VERSION=3

# Create the service entity and API endpoints
openstack service create \
--name keystone --description "OpenStack Identity" identity

openstack endpoint create --region $REGION \
identity public $PUBLIC_URL

openstack endpoint create --region $REGION \
identity internal $INTERNAL_URL

openstack endpoint create --region $REGION \
identity admin $ADMIN_URL

# Create a domain, projects, users, and roles
openstack domain create --description "Default Domain" default

openstack project create --domain default \
--description "Admin Project" admin

openstack user create --domain default \
--password $PASSWORD admin

openstack role create admin

openstack role add --project admin --user admin admin

openstack project create --domain default \
--description "Service Project" service

openstack project create --domain default \
--description "Demo Project" demo

openstack user create --domain default \
--password $PASSWORD demo

openstack role create user

openstack role add --project demo --user demo user
