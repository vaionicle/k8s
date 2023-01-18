#!/bin/bash

NODE=${1:-""}

if [ "${NODE}" == "" ]; then
    echo "NODE ID is not set"
    echo "./src/scripts/install_ubuntu.sh 1..N"
    return
fi

VM_GROUP="k8s"
VM_LOCATION="/opt/VirtualBox"

ISO_VERSION="22.04.1"
ISO_FILE="ubuntu-${ISO_VERSION}-live-server-amd64.iso"

[ ! -f "${ISO_FILE}" ] && wget https://releases.ubuntu.com/${ISO_VERSION}/${ISO_FILE}

tmpdir=./src/configs
vm_name="k8s_node_${NODE}"

metadata=$"instance-id: kuberneters-node-${NODE}"$'\nlocal-hostname: k8snode'${NODE}
echo "$metadata" > ./src/configs/meta-data

mkisofs -JR -V cidata -o ./seed_${NODE}.iso ${tmpdir}

DESC=$'username: user\npassword: ubuntu\nhostname: k8snode'"${NODE}"
VBoxManage modifyvm ${vm_name} --description "$(echo "$DESC")"

VBoxManage storageattach ${vm_name} --storagectl "SATA" --port 1 --device 0 --type dvddrive --medium ${ISO_FILE}
VBoxManage storageattach ${vm_name} --storagectl "SATA" --port 2 --device 0 --type dvddrive --medium seed_${NODE}.iso

VBoxManage startvm ${vm_name} --type=gui

tree ${VM_LOCATION}/${VM_GROUP}
du -h ${VM_LOCATION}/${VM_GROUP}