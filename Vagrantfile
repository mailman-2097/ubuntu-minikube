# -*- mode: ruby -*-
# vi: set ft=ruby :

IP_SRVR = "192.168.10.10"
IP_N1 = "192.168.10.11"

VAGRANTFILE_API_VERSION = "2"
BOX_IMAGE = "ubuntu/jammy64"
BOX_IMAGE_1 = "ubuntu/focal64"
AUTOSTART = true

$dns_script = <<SCRIPT
echo "$1	minikube.local	 minikube" >> /etc/hosts
echo "$2	tentacle.local	 tentacle" >> /etc/hosts
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
					vb.customize ["modifyvm", :id, "--memory", 10024]
					vb.customize ["modifyvm", :id, "--name", "minikube"]
					vb.customize ["modifyvm", :id, "--cpus", "2"]
		end
end

config.vm.define "tentacle", autostart: AUTOSTART	do |node|
    node.vm.box = BOX_IMAGE_1
    node.vm.hostname = 'tentacle.local'
    node.vm.network :private_network, ip: IP_N1
    node.vm.network :forwarded_port, guest: 22, host: 8833, id: "ssh"
    node.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant"

    node.vm.provision "shell" do |s|
        s.inline = $dns_script
        s.args = [IP_SRVR, IP_N1]
    end

    node.vm.provision "shell", path: "script/setup-linux-tentacle.sh"

    node.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
                vb.customize ["modifyvm", :id, "--memory", 1024]
                vb.customize ["modifyvm", :id, "--name", "tentacle"]
                vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
end

end