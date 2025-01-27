# Vagrantfile.j2
Vagrant.configure("2") do |config|
  # Define the base box
  config.vm.box = "bento/ubuntu-20.04"
  # config.vm.disk :disk, primary: true, size: "30GB"
  # disk setting stays here, but bento/ubuntu seems to allocate 62GB and no less. KNative requires at least 20GB
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096 # 4GB of RAM memory per machine
    v.cpus = 4 # 4 CPU threads per machine
  end

  # Create the three connected machines, each with one private network interface
  (1..3).each do |i|
    config.vm.define "vm#{i}" do |connected|
      connected.vm.hostname = "vm#{i}"
      connected.vm.network "private_network", ip: "192.168.0.#{i+1}", virtualbox__intnet: "internal"
      connected.vm.network "private_network", ip: "192.168.56.#{i+1}"
      connected.vm.synced_folder "./data", "/shared_storage", type: "nfs", nfs_version: 3, nfs_udp: false, linux__nfs_options: ['rw', 'no_root_squash']
    end
  end
end
