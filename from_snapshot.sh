#!/bin/bash

# Restarts cluster to defined snapshot and re-runs all playbooks

vagrant snapshot restore cluster-snapshot

python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json
./playbooks.sh