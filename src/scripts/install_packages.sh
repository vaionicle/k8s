#!/bin/bash

sudo apt update
sudo apt upgrade -y


# install engines
sudo apt install virtualbox

# minikube
MINIKUBE="minikube_latest_amd64.deb"
curl -LO https://storage.googleapis.com/minikube/releases/latest/${MINIKUBE}
sudo dpkg -i ${MINIKUBE}


# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo 'source <(kubectl completion bash)' >>~/.bashrc