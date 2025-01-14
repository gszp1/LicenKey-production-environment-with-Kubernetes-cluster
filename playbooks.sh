#!/bin/bash
ansible-playbook -i ./build/hosts.ini ./ansible/kubernetes-common.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/control-plane.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/worker.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/nfs.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/csi.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/helm.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/cert-manager.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/metallb/metallb.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/nginx-ingress.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/routing/certificates.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/docker_registry/docker-registry.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/routing/registry-external-name.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/routing/routing-ingress.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/routing/share-certificate.yaml