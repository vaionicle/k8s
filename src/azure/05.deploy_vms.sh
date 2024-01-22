#!/bin/bash

# https://docs.microsoft.com/en-us/cli/azure/network/vnet?view=azure-cli-latest 

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/_config.sh

# CREATE RESOURCE GROUP
echo "--- CREATE RESOURCE GROUP"
az group create --name ${RG} --location ${LOCATION} --tags ${TAGS}


az vm create \
    -n kube-master-1 \
    -g kubeadm \
    --image UbuntuLTS \
    --vnet-name kubeadm --subnet kube \
    --admin-username nilfranadmin \
    --ssh-key-value @~/.ssh/id_rsa.pub \
    --size Standard_D2ds_v4 \
    --nsg kubeadm \
    --public-ip-sku Standard --no-wait

az vm create \
    -n kube-master-2 \
    -g kubeadm \
    --image UbuntuLTS \
    --vnet-name kubeadm --subnet kube \
    --admin-username nilfranadmin \
    --ssh-key-value @~/.ssh/id_rsa.pub \
    --size Standard_D2ds_v4 \
    --nsg kubeadm \
    --public-ip-sku Standard --no-wait

az vm create \
    -n kube-worker-1 \
    -g kubeadm \
    --image UbuntuLTS \
    --vnet-name kubeadm --subnet kube \
    --admin-username nilfranadmin \
    --ssh-key-value @~/.ssh/id_rsa.pub \
    --size Standard_D2ds_v4 \
    --nsg kubeadm \
    --public-ip-sku Standard --no-wait

az vm create \
    -n kube-worker-2 \
    -g kubeadm \
    --image UbuntuLTS \
    --vnet-name kubeadm --subnet kube \
    --admin-username nilfranadmin \
    --ssh-key-value @~/.ssh/id_rsa.pub \
    --size Standard_D2ds_v4 \
    --nsg kubeadm \
    --public-ip-sku Standard






















# # CREATE NETWORK
# echo "--- CREATE VNET"
# az network vnet create \
#   --name "${PRIVATE_NET}" \
#   --resource-group "${RG}" \
#   --address-prefixes 10.0.0.0/16 \
#   --subnet-name "${PRIVATE_NET}.subnet" \
#   --subnet-prefixes 10.0.0.0/24

# echo "--- CREATE PUBLIC IP"
# az network public-ip create \
#   --name "${PUBLIC_NET}" \
#   --resource-group "${RG}" \
#   --allocation-method "Static"

# for box in "nodecp" "node1" "node2"; do
#   echo "--- CREATE SSH KEYS FOR $box"
#   az sshkey create --name "${box}.ssh.${A_USER}" --resource-group "${RG}" --tags "${TAGS}"

#   echo "--- CREATE $box VM"
#   az vm create \
#     --name              "${box}.vm" \
#     --resource-group    "${RG}" \
#     --computer-name     "backend" \
#     --image             "${IMAGE_ID}" \
#     --size              "${INSTANCE_SIZE}" \
#     --storage-sku       "${INSTANCE_DISK_SKU}" \
#     --ssh-key-name      "${box}.ssh.${A_USER}" \
#     --vnet-name         "${PRIVATE_NET}" \
#     --subnet            "${PRIVATE_NET}.subnet" \
#     --public-ip-address "" \
#     --tags              "${TAGS}"
# done

# az network nic ip-config update \
#   --name ipconfigmyVM \
#   --nic-name myVMVMNic \
#   --resource-group myResourceGroup \
#   --public-ip-address myVMPublicIP

# az vm run-command invoke \
#    -g myResourceGroup \
#    -n myVM \
#    --command-id RunShellScript \
#    --scripts "sudo apt-get update && sudo apt-get install -y nginx"
# az vm open-port --port 80 --resource-group myResourceGroup --name myVM
# az group delete --name ${RG}

# az vm image list --architecture x64 --publisher canonical --offer "0001-com-ubuntu-server-focal" --all --output table