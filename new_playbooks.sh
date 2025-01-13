#!/bin/bash
# DO NOT ENTER ANY EXTRA SPAPCES, NEW LINES OR OTHER COMMANDS BETWEEN, AFTER OR BEFORE PLAYBOOK CALLS
ansible-playbook -i ./build/hosts.ini ./ansible/cert-manager.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/metallb/metallb.yaml
ansible-playbook -i ./build/hosts.ini ./ansible/nginx-ingress.yaml
