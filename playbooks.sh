#!/bin/bash

# Configure virtual machines for kubernetes cluster
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/kubernetes-common.yaml

# Additional configuration for master node
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/control-plane.yaml

# Additional configuration for worker nodes
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/worker.yaml

# Adds NFS tools for worker nodes
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/nfs.yaml

# Sets up NFS Container Storage Interface driver
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/csi.yaml

# Sets up Helm on master node
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/helm.yaml

# Adds cert-manager through Helm chart
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/cert-manager.yaml

# Adds MetalLB through Helm chart
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/metallb.yaml

# Adds NGINX ingress controller via Helm chart
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/nginx-ingress.yaml

# Creates Persistent Volume, Persistent Volume Claim and Docker Registry exposed via NodePort
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/setup/docker-registry.yaml

# Creates Certificates and Issuers for encrypted communication with Docker Registry
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/certificates.yaml

# Adds file with CA certificate from certificate to shared space
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/share-certificate.yaml

# Creates secret with htpasswd file 
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/registry-authentication.yaml

# Adds Ingress redirecting to Docker Registry. Provides encryption and authentication
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/routing-ingress.yaml

# Configure nodes to be able to connect with registry ingress
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/node-traffic-config.yaml
