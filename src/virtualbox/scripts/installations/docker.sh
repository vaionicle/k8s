#!/bin/bash

# REMOVE OLD VERSION
sudo apt remove snapd -y
sudo apt remove docker docker.io containerd runc

# ADDING DOCKER REPOS
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# INSTALLING PACKAGES
sudo apt-get update
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

sudo apt autoremove -y
sudo apt autoclean -y

# SETTING UP PERMISSIONS
sudo groupadd docker
sudo usermod -aG docker ${USER}
mkdir -p /home/"$USER"/.docker
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R

# CONFIGURE
containerd config default | sudo tee /etc/containerd/config.toml

sudo sed -e 's/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml
sudo systemctl restart containerd
