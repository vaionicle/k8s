#!/bin/bash

STABLE=$(curl -L -s https://dl.k8s.io/release/stable.txt)
BETA=$(curl -L -s https://dl.k8s.io/release/beta.txt)

curl -LO "https://dl.k8s.io/release/${STABLE}/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/${STABLE}/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo 'source <(kubectl completion bash)' >> ~/.bashrc

kubectl version


rm -rf kubectl kubectl.sha256