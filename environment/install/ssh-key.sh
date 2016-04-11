#! /usr/bin/bash

ssh-keygen -t rsa -f /home/core/.ssh/id_rsa -N ''
cat /home/core/.ssh/id_rsa.pub >> /home/core/.ssh/authorized_keys
ssh-keyscan localhost >> /home/core/.ssh/known_hosts
