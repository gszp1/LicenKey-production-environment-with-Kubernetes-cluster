# Meaning of the files residing in this directory

# Before the cluster is being setup, following commands have to be run:
- `sudo mkdir -p /home/nfs`
- 


## init.sh - setup cluster
- `vagrant up` - setup 3 virtual machines that can communicate with each other,
- `python3 ./scripts/get_ansible_hosts.py ./config/cluster_config.json` - initialize `hosts.ini` hosts inventory file,
- `ansible-playbook -i ./build/hosts.ini ./ansible/kubernetes-common.yml` - install common binaries for kubernetes that must be present on all the nodes.
- `ansible-playbook -i ./build/hosts.ini ./ansible/control-plane.yml` - setup Control Plane
- `ansible-playbook -i ./build/hosts.ini ./ansible/worker.yml` - setup Worker Nodes

## cluster_config.json - cluster configuration in json format
Meaning of the following groups is as follows:
- `kubernetes_common` - commands applied on all the nodes that take part in kubernetes cluster provisioning,
- `control_plane` - commands executed only on `Control Plane` nodes,
- `workers` - commands executed only on `Worker` nodes.


## get_ansible_hosts.py - generate ansible host files
__Important:__ Must be executed after `vagrant up` will be ran and command `vagrant ssh-config` returns valid ssh config for virtual machines.

1) Verifies if all the hosts present in `cluster_config.json` are available after performing provisioning of virtual machines. In case there exists host in config that was not provisioned, error will be thrown.
2) Constructs host file for `ansible`, with host configurations at the top and assigning hosts to specific groups. Specific groups will have group of hosts present on which specific commands will be executed.
