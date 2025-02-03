#!/bin/bash

# Configure virtual machines for kubernetes cluster
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/kubernetes-common.yaml

# Additional configuration for master node
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/control-plane.yaml

# Additional configuration for worker nodes
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/worker.yaml

# Adds NFS tools for worker nodes
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/nfs.yaml

# Creates secret with htpasswd file, saves credentials, htpasswd content, auth structure to files
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/htpasswd.yaml

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

# Creates secret with credentials to docker registry for pods
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/auth-secrets.yaml

# Creates Certificates and Issuers for encrypted communication with Docker Registry
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/certificates.yaml

# Adds file with CA certificate from certificate to shared space
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/share-certificate.yaml

# Configure nodes to be able to connect with registry ingress
# Configure nodes to login into docker registry
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/nodes-tls-config.yaml

# Configure containerd for docker regitry authentication
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/containerd-config.yaml

# Creates Persistent Volume, Persistent Volume Claim and Docker Registry exposed via NodePort
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/setup/docker-registry.yaml

# Adds Ingress redirecting to Docker Registry. Provides secure connection via HTTP + TLS
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/routing-ingress.yaml

# Make all nodes login to docker registry
ansible-playbook -i ./build/hosts.ini ./ansible/docker-registry/routing/docker-login.yaml

# Creates NFS Storage Class
ansible-playbook -i ./build/hosts.ini ./ansible/cluster-config/nfs-storage-class.yaml

# Install Strimzi in cluster
ansible-playbook -i ./build/hosts.ini ./ansible/strimzi/install.yaml

# Add Strimzi roles
ansible-playbook -i ./build/hosts.ini ./ansible/strimzi/roles.yaml

# Install kafka cluster
ansible-playbook -i ./build/hosts.ini ./ansible/strimzi/cluster.yaml

# Install KNative Serving component
ansible-playbook -i ./build/hosts.ini ./ansible/knative/install-serving.yaml

# Install KNative Kourier networking layer
ansible-playbook -i ./build/hosts.ini ./ansible/knative/install-kourier.yaml

# Install KNative Eventing component
ansible-playbook -i ./build/hosts.ini ./ansible/knative/install-eventing.yaml

# Instal KNative Eventing Kafka components
ansible-playbook -i ./build/hosts.ini ./ansible/knative/install-eventing-kafka.yaml

# Install Postgres database in cluster
ansible-playbook -i ./build/hosts.ini ./ansible/postgres/create-database.yaml

# Create kafka topics
ansible-playbook -i ./build/hosts.ini ./ansible/strimzi/create-topics.yaml

# Create backend application
ansible-playbook -i ./build/hosts.ini ./ansible/backend/create-backend-app.yaml

# Create knative service for orders function
ansible-playbook -i ./build/hosts.ini ./ansible/backend/order-function.yaml

# Create key generation services
ansible-playbook -i ./build/hosts.ini ./ansible/key-gen-service/create-key-gen-services.yaml