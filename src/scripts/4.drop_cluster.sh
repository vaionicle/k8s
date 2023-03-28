#!/bin/bash

VM_GROUP="k8s"
VM_LOCATION="/opt/VirtualBox"
VM_NAT_NETWORK="k8s"
VM_COUNT=4

[ $(VBoxManage natnetwork list ${VM_NAT_NETWORK} | wc -l) == 3 ] && \
	VBoxManage natnetwork add --netname ${VM_NAT_NETWORK} --network "10.0.2.0/24" --enable --dhcp on && \
	VBoxManage natnetwork start --netname ${VM_NAT_NETWORK}

VBoxManage natnetwork list ${VM_NAT_NETWORK}

for i in $(seq ${VM_COUNT}); do
	vm_name="k8s_node_${i}"
	vm_disk="${VM_LOCATION}/${VM_GROUP}/${vm_name}/${vm_name}.vdi"

	if [ $(VBoxManage list runningvms | grep ${vm_name} | wc -l) == "1" ]; then
		echo "STOPPING ${vm_name}"

		VBoxManage controlvm ${vm_name} poweroff
	fi

	echo "DELETING ${vm_name}"

	VBoxManage unregistervm ${vm_name} --delete
done

tree ${VM_LOCATION}/${VM_GROUP}

du -h ${VM_LOCATION}/${VM_GROUP}