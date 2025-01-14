#!/bin/bash

# Creates Virtual Machines with kubernetes cluster

mkdir -p ./ansible/tmp
if ! vagrant up; then
    echo "Failed to create VMs."
    exit 1
fi

# Create and configure k8s cluster on VMs
python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json
./playbooks.sh