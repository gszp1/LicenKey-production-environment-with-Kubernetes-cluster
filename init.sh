#!/bin/bash

mkdir -p ./ansible/tmp
vagrant up
python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json
# ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/docker-registry-node-config.yaml # Moved to the start before cluster is created
ansible-playbook -i ./build/hosts.ini ./ansible/kubernetes-common.yml
ansible-playbook -i ./build/hosts.ini ./ansible/control-plane.yml
ansible-playbook -i ./build/hosts.ini ./ansible/worker.yml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/nfs.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/csi.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/docker-registry.yaml
# ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/docker-registry-node-config.yaml # CHECK IF IT DOES NOT BREAK CLUSTER BY RESTARTING DAEMONS
# rm -rf ./tmp