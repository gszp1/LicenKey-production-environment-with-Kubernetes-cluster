#!/bin/bash

# Runs vagrant to create virtual machines on which cluster will be run
# Creates Snapshot with machines state before cluster setup
# Runs playbooks that create cluster on virtual machines

vagrant snapshot delete cluster-snapshot || echo "No previously saved snapshots - creating new snapshot"

mkdir -p ./ansible/tmp
if ! vagrant up; then
    echo "Failed to create VMs."
    exit 1
fi

if ! vagrant status | grep -v "running" | grep -q "state";then
    echo "Skipping snapshot creation - at least one of the VMs is not running."
else
    if ! vagrant snapshot save cluster-snapshot; then 
        echo "Failed to create snapshot."
    else 
        echo "Snapshot with name 'cluster-snapshot' created."
    fi 
fi

python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json
./playbooks.sh