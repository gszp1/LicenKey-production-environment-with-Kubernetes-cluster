#!/bin/bash

vagrant snapshot delete cluster-snapshot || echo "No previously saved snapshots - creating new snapshot"

mkdir -p ./ansible/tmp
if ! vagrant up; then
    echo "Failed to create VMs."
    exit 1
fi

python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json
ansible-playbook -i ./build/hosts.ini ./ansible/kubernetes-common.yml
ansible-playbook -i ./build/hosts.ini ./ansible/control-plane.yml
ansible-playbook -i ./build/hosts.ini ./ansible/worker.yml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/nfs.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/csi.yaml

if ! vagrant status | grep -v "running" | grep -q "state";then
    echo "Skipping snapshot creation - at least one of the VMs is not running."
else
    if ! vagrant snapshot save cluster-snapshot; then 
        echo "Failed to create snapshot."
    else 
        echo "Snapshot with name 'cluster-snapshot' created."
    fi 
fi