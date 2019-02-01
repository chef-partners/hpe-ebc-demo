#!/bin/sh

CHEFSERVER=ebcdemochefserver
CHEFSERVER_FQDN=ebcdemochefserver.hpelab
CHEFSERVER_IP=10.50.9.68
DATASTORE=3PAR_SYN02
LINUX_TEMPLATE=LinuxTemp
LINUX_NODE=NationalParksWebServer
SSH_USER=root
SSH_PWD='password'

knife vsphere vm clone $LINUX_NODE --template $LINUX_TEMPLATE --cips dhcp --start --datastore $DATASTORE --bootstrap --ssh-user $SSH_USER --ssh-password $SSH_PWD --node-ssl-verify-mode none --run-list audit_wrapper,chef_client_wrapper,opsfirewall,hab_national_parks -N $LINUX_NODE

NODE_IP=`knife node show ${LINUX_NODE} | grep IP: | cut -d: -f2 | sed 's/^ *//'`
cp /etc/hosts /etc/hosts.bak

echo "${NODE_IP} ${LINUX_NODE}.hpelab" >> /etc/hosts

