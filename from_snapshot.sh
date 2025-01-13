#!/bin/bash

vagrant snapshot restore cluster-snapshot

ansible-playbook -i ./build/hosts.ini ./ansible/helm.yaml
# ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/docker-registry.yaml