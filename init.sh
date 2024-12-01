#!/bin/bash

mkdir -p ./tmp
vagrant up
python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json
ansible-playbook -i ./build/hosts.ini ./ansible/kubernetes-common.yml
ansible-playbook -i ./build/hosts.ini ./ansible/control-plane.yml
ansible-playbook -i ./build/hosts.ini ./ansible/worker.yml
# rm -rf ./tmp