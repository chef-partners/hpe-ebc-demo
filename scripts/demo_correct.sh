#!/bin/sh

LINUX_NODE=NationalParksWebServer
SSH_USER=root
SSH_PWD='password'

knife node run_list add $LINUX_NODE recipe[sshd]
knife ssh "name:${LINUX_NODE}" 'sudo chef-client' --ssh-password $SSH_PWD -a ${LINUX_NODE}
