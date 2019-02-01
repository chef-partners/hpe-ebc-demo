#!/bin/sh

LINUX_NODE=NPWebServer
SSH_USER=root
SSH_PWD='password'
SYN_NODE=Syn1

knife vsphere vm delete $LINUX_NODE -P 

mv /etc/hosts.bak /etc/hosts
