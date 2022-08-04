#! /bin/bash -e
cp /etc/apt/sources.list /etc/apt/sources.list.0
sed -i -E "s|http://us.|http://|g" /etc/apt/sources.list
apt-get update -y
apt-get upgrade -y
apt-get install software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install ansible -y
ansible-galaxy collection install community.general

pushd /vagrant
ansible-playbook provisioning/ansible/playbook.yml
popd

sudo usermod -a -G docker vagrant

pushd /tmp

# minikube 
# Container or virtual machine manager, such as: Docker, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, or VMware Fusion/Workstation
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client --output=yaml

popd

#kvm2 : may not work on virtual box
# sudo apt install --no-install-recommends qemu-system libvirt-clients libvirt-daemon-system
# adduser vagrant libvirt
# virt-host-validate
# virsh list --all

echo "run minikube start to continue with further setup"
