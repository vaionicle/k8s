# KUBEADM

## Create a single control plane

subo kubeadm init


## Create a single node

sudo kubeadm init --config kubeadm-config.yaml --upload-certs | tee kubeadm-init.out



sudo kubeadm token list
sudo kubeadm token create --config 