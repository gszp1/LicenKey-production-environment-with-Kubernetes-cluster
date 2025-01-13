#!/bin/bash

# Create VMs
mkdir -p ./ansible/tmp
if ! vagrant up; then
    echo "Failed to create VMs."
    exit 1
fi

# Create and configure k8s cluster on VMs
python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json
ansible-playbook -i ./build/hosts.ini ./ansible/kubernetes-common.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/control-plane.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/worker.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/nfs.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/csi.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/helm.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/docker-registry.yaml