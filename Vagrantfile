# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    config.vm.box = "centos/7"
	config.vm.box_check_update = false
	
	config.vm.define "master" do |master|
		master.vm.hostname="master.internal"
		master.vm.network :private_network, ip: "192.168.33.50"
		master.vm.provider :virtualbox do |ps|
		  ps.memory=2048
		end
		master.vm.provision "shell", path: "scripts/k8s-cluster-init.sh"
		master.vm.provision "shell", path: "scripts/k8s-master-init.sh"
	end
	
	config.vm.define "node1" do |node1|
		node1.vm.hostname="node1.internal"
		node1.vm.network :private_network, ip: "192.168.33.51"
		node1.vm.provider :virtualbox do |ps|
			ps.memory=2048
		end
		node1.vm.provision "shell", path: "scripts/k8s-cluster-init.sh"
		node1.vm.provision "shell",	path: "scripts/k8s-node-init.sh"
	end 
end
