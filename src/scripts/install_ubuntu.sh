#!/bin/bash

VM_COUNT=4

ISO_VERSION="22.04.1"
ISO_FILE="ubuntu-${ISO_VERSION}-live-server-amd64.iso"

[ ! -f "${ISO_FILE}" ] && wget https://releases.ubuntu.com/${ISO_VERSION}/${ISO_FILE}

tmpdir=./src/configs

for i in $(seq ${VM_COUNT}); do
	vm_name="k8s_node_${i}"

    metadata=$"instance-id: id-${i}"$'\nlocal-hostname: k8s-node'${i}

    echo "$metadata" > ./src/configs/meta-data

    mkisofs -JR -V cidata -o ./seed_${i}.iso ${tmpdir}

    # VBoxManage storageattach ${vm_name} --storagectl "SATA" --port 1 --device 0 --type dvddrive --medium ${ISO_FILE}
    # VBoxManage storageattach ${vm_name} --storagectl "SATA" --port 2 --device 0 --type dvddrive --medium ./seed_${i}.iso
done
