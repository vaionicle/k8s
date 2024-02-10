#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y \
    vim \
    nano \
    tree \
    zerofree \
    net-tools \
    network-manager \
    bzip2 \
    tar \
    git \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    gnupg2 \
    virtualbox-guest-utils \
    software-properties-common \
    uidmap \
    bridge-utils

sudo apt-get autoremove
sudo apt-get autoclean

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
overlay
EOF


cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system
