#!/bin/bash

vagrant snapshot delete cluster-snapshot || echo "No previously saved snapshots - creating new snapshot"

./init.sh

if ! vagrant status | grep -v "running" | grep -q "state";then
    echo "Skipping snapshot creation - at least one of the VMs is not running."
else
    if ! vagrant snapshot save cluster-snapshot; then 
        echo "Failed to create snapshot."
    else 
        echo "Snapshot with name 'cluster-snapshot' created."
    fi 
fi