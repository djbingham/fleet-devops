#!/usr/bin/env bash

vagrant ssh-config | sed -n "s/IdentityFile//gp" | xargs ssh-add
export FLEETCTL_TUNNEL="$(vagrant ssh-config | sed -n "s/[ ]*HostName[ ]*//gp"):$(vagrant ssh-config | sed -n "s/[ ]*Port[ ]*//gp")"
