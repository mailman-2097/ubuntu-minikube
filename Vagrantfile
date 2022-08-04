# -*- mode: ruby -*-
# vi: set ft=ruby :

IP_SRVR = "192.168.10.10"

VAGRANTFILE_API_VERSION = "2"
BOX_IMAGE = "geerlingguy/ubuntu2004"
AUTOSTART = true

$dns_script = <<SCRIPT
echo "$1	ubuntuvm.local	 ubuntuvm" >> /etc/hosts 
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

config.vm.define "ubuntuvm", autostart: AUTOSTART	do |ubuntuvm|
		ubuntuvm.vm.box = BOX_IMAGE
		ubuntuvm.vm.hostname = 'ubuntuvm.local'
		ubuntuvm.vm.network :private_network, ip: IP_SRVR
		ubuntuvm.vm.network :forwarded_port, guest: 22, host: 8822, id: "ssh"
    	ubuntuvm.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant"
		ubuntuvm.vm.provision "shell" do |s|
			s.inline = $dns_script
			s.args = [IP_SRVR]
		end
		ubuntuvm.vm.provision "shell", path: "script/setup.sh"

		ubuntuvm.vm.provider :virtualbox do |vb|
					vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
					vb.customize ["modifyvm", :id, "--memory", 4096]
					vb.customize ["modifyvm", :id, "--name", "ubuntuvm"]
					vb.customize ["modifyvm", :id, "--cpus", "2"]
		end
end
end