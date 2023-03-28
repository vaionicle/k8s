#!/bin/bash

K8S_VERSION=${1:-"1.26.0"}

[ ! $(whoami) == "root" ] && echo "RUN ME AS ROOT USER" && exit

swapoff -a

apt update
apt upgrade -y

apt install -y vim nano tree zerofree \
	curl apt-transport-https git wget gnupg2 \
	software-properties-common lsb-release ca-certificates uidmap

apt autoremove -y
apt autoclean -y

modprobe overlay
modprobe br_netfilter

if [ ! -f /etc/sysctl.d/k8s.conf ]; then

cat << EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

	sysctl --system
fi

mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --yes --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update 
apt install containerd.io -y

containerd config default | tee /etc/containerd/config.toml

sed -e 's/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml
systemctl restart containerd

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
	https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt update
apt install -y kubeadm=${K8S_VERSION}-00 kubelet=${K8S_VERSION}-00 kubectl=${K8S_VERSION}-00
apt-mark hold kubelet kubeadm kubectl


kubeadm version
kubectl version
kubelet --version