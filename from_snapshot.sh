#!/bin/bash

vagrant snapshot restore cluster-snapshot

python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json
./playbooks.sh

./new_playbooks.sh