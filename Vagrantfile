# Vagrantfile.j2
Vagrant.configure("2") do |config|
  # Define the base box
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.provider "virtualbox" do |v|
    v.memory = 3072
    v.cpus = 4
  end

  # Create the three connected machines, each with one private network interface
  (1..3).each do |i|
    config.vm.define "vm#{i}" do |connected|
      connected.vm.hostname = "vm#{i}"
      connected.vm.network "private_network", ip: "192.168.0.#{i+1}", virtualbox__intnet: "internal"
      connected.vm.network "private_network", ip: "192.168.56.#{i+1}"
      connected.vm.synced_folder "./data", "/shared_storage"
    end
  end
end
