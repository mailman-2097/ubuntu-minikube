# -*- mode: ruby -*-
# vi: set ft=ruby :

IP_SRVR = "192.168.10.10"

VAGRANTFILE_API_VERSION = "2"
BOX_IMAGE = "ubuntu/focal64"
AUTOSTART = true

$dns_script = <<SCRIPT
echo "$1	minikube.local	 minikube" >> /etc/hosts 
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

config.vm.define "minikube", autostart: AUTOSTART	do |master|
		master.vm.box = BOX_IMAGE
		master.vm.hostname = 'minikube.local'
		master.vm.network :private_network, ip: IP_SRVR
		master.vm.network :forwarded_port, guest: 22, host: 8822, id: "ssh"
    	master.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant"
		master.vm.provision "shell" do |s|
			s.inline = $dns_script
			s.args = [IP_SRVR]
		end
		master.vm.provision "shell", path: "script/setup.sh"

		master.vm.provider :virtualbox do |vb|
					vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
					vb.customize ["modifyvm", :id, "--memory", 9999]
					vb.customize ["modifyvm", :id, "--name", "minikube"]
					vb.customize ["modifyvm", :id, "--cpus", "2"]
		end
end
end