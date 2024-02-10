#!/bin/bash

KUBE_VERSION="v1.26"
KUBE_APPS="kubelet kubeadm kubectl"

sudo apt-mark unhold ${KUBE_APPS}
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo apt-get install -y ${KUBE_APPS}
sudo apt-mark hold ${KUBE_APPS}

sudo crictl config \
    --set runtime-endpoint="unix:///run/containerd/containerd.sock" \
    --set image-endpoint="unix:///run/containerd/containerd.sock"

sudo crictl ps


# echo 'source <(kubectl completion bash)' >> ~/.bashrc
# echo 'source <(kubeadm completion bash)' >> ~/.bashrc
# kubectl version
# rm -rf kubectl kubectl.sha256