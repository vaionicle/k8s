#!/bin/bash


sudo apt-get install \
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

echo 'user ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/ubuntu
# sed -ie 's/GRUB_CMDLINE_LINUX=.\*/GRUB_CMDLINE_LINUX="net.ifnames=0 ipv6.disable=1 biosdevname=0 console=ttyS0,115200n8"/' /etc/default/grub

#curtin in-target --target /target update-grub2
#swapoff -a
#sed -ie '/\/swap.img/s/^/#/g' /etc/fstab

#truncate -s 0 /swap.img
#|
#     cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
#     br_netfilter
#     overlay
#     EOF
#|
#     cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
#     net.bridge.bridge-nf-call-ip6tables = 1
#     net.bridge.bridge-nf-call-iptables  = 1
#     net.ipv4.ip_forward                 = 1
#     EOF
#sysctl --system

#echo 'vboxsf' | tee -a /etc/modules
#echo 'k8s /opt/k8s vboxsf defaults,uid=1000,gid=1000,umask=022 0 0' | tee -a /etc/fstab

#|
#     cat <<EOF | sudo tee /etc/systemd/system/announce_ip.service
#     [Unit]
#     Description=Announce Ip address for that VM
#     After=local-fs.target
#     After=network.target

#     [Service]
#     ExecStart=/opt/k8s/src/virtualbox/scripts/announce_ip.sh
#     Type=oneshot
#     RemainAfterExit=yes
#     User=user
#     Group=user

#     [Install]
#     WantedBy=multi-user.target
#chmod 664 /etc/systemd/system/announce_ip.service

#curtin in-target --target /target systemctl daemon-reload
#curtin in-target --target /target systemctl enable announce_ip.service