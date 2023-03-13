#!/bin/bash

sudo swapoff -a
sudo truncate -s 0 /swap.img

sudo apt remove snapd -y
sudo apt remove docker docker.io containerd runc

# install engines
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt upgrade -y
sudo apt install -y \
    virtualbox \
    docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo apt autoremove -y
sudo apt autoclean -y

# minikube
MINIKUBE="minikube_latest_amd64.deb"
curl -LO https://storage.googleapis.com/minikube/releases/latest/${MINIKUBE}
sudo dpkg -i ${MINIKUBE}
rm -rf ${MINIKUBE}

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo 'source <(kubectl completion bash)' >>~/.bashrc


sudo usermod -aG docker $USER && newgrp docker
minikube start --driver="docker"

df /