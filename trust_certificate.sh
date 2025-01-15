#!/bin/bash

# Adds certificate used for HTTPS connection with ingress to trusted certificates

sudo rm ./usr/local/share/ca-certificates/ca.crt

sudo cp ./data/share/ca.crt /usr/local/share/ca-certificates/ca.crt

sudo update-ca-certificates

curl --cacert ./data/share/ca.crt https://docker-registry.cluster.local
