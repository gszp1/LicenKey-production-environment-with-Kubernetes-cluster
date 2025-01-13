#!/bin/bash

# Create VMs
mkdir -p ./ansible/tmp
vagrant up

# Create and configure k8s cluster on VMs
python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json
ansible-playbook -i ./build/hosts.ini ./ansible/kubernetes-common.yml
ansible-playbook -i ./build/hosts.ini ./ansible/control-plane.yml
ansible-playbook -i ./build/hosts.ini ./ansible/worker.yml
ansible-playbook -i ./build/hosts.ini ./ansible/helm.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/nfs.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/csi.yaml

# Create k8s objects 
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/docker-registry.yaml

# rm -rf ./tmp