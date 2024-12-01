import subprocess
import os
import sys
import json


def get_vagrant_ssh_config():
    result = subprocess.run(['vagrant', 'ssh-config'], capture_output=True, text=True)
    return result.stdout

def parse_ssh_config(ssh_config):
    hosts = {}
    current_host = None
    for line in ssh_config.splitlines():
        if line.startswith('Host '):
            current_host = line.split()[1]
            hosts[current_host] = {}
        elif current_host and line.strip():
            key, value = line.strip().split(None, 1)
            hosts[current_host][key] = value
    return hosts

def generate_ansible_inventory(hosts, cluster_config):
    # print('[vagrant]')
    host_def = ""
    for host, config in hosts.items():
        ansible_host = config.get('HostName', '127.0.0.1')
        ansible_port = config.get('Port', '22')
        ansible_user = config.get('User', 'vagrant')
        ansible_private_key_file = config.get('IdentityFile')
        host_def += f"{host} ansible_host={ansible_host} ansible_port={ansible_port} ansible_user={ansible_user} ansible_private_key_file={ansible_private_key_file} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'"
        host_def += '\n'
    
    for group, hosts in cluster_config.items():
        hosts_formatted = "\n".join(hosts)
        host_def += f"[{group}]\n{hosts_formatted}\n"
    return host_def

def load_cluster_config(cluster_config_file):
    with open(cluster_config_file, "r+") as f:
        return json.load(f)

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(f"Expected 1 arguments: [cluster-config]")
        exit(1)
    cluster_config = load_cluster_config(sys.argv[1])
        
    
    ssh_config = get_vagrant_ssh_config()
    hosts = parse_ssh_config(ssh_config)
    ansible_inventory = generate_ansible_inventory(hosts, cluster_config)
    with open("./build/hosts.ini", "w+") as f:
        f.write(ansible_inventory)
    # print(generate_ansible_inventory(hosts, cluster_config))