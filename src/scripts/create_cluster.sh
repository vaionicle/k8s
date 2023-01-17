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

	if [ $(VBoxManage list vms -s | grep ${vm_name} | wc -l) == "0" ]; then
		echo "CREATING ${vm_name}"

		VBoxManage createvm \
			--name ${vm_name} \
			--groups "/${VM_GROUP}" \
			--ostype Ubuntu_64 \
			--register \
			--basefolder "${VM_LOCATION}"

		VBoxManage storagectl ${vm_name} --name "SATA" --add sata --controller IntelAhci
	else
		echo "EXISTS ${vm_name}"
	fi

	# General Settings
	VBoxManage modifyvm ${vm_name} \
		--clipboard-mode bidirectional \
		--draganddrop bidirectional

	DESC=$'username: user\npassword: azerty\nhostname: k8snode'"${i}"
	VBoxManage modifyvm ${vm_name} --description "$(echo "$DESC")"

	# System Settings
	VBoxManage modifyvm ${vm_name} \
		--ioapic on \
		--pae on \
		--chipset piix3 \
		--memory 1024 \
		--cpus 1 \
		--cpuexecutioncap 100 \
		--rtcuseutc on

	VBoxManage modifyvm ${vm_name} \
		--boot1 dvd \
		--boot2 disk \
		--boot3 none \
		--boot4 none

	# Display Settings
	VBoxManage modifyvm ${vm_name} --vram 16 --graphicscontroller vmsvga

	# # Storage Settings
	if [ $(VBoxManage list hdds -s | grep "${vm_disk}" | wc -l) == "0" ]; then
		echo "Disk ${vm_disk} for ${vm_name} | CREATING"
		VBoxManage createhd --filename ${vm_disk} --size 10240 --format VDI
	else
		echo "Disk ${vm_disk} for ${vm_name} | EXISTS"
	fi

	# SATA
	VBoxManage storageattach ${vm_name} --storagectl "SATA" --port 0 --device 0 --type hdd --medium ${vm_disk}

	# Audio Settings
	VBoxManage modifyvm ${vm_name} --audio none

	# Network Settings
	ID="1"
	VBoxManage modifyvm ${vm_name} --nic${ID} natnetwork	--nictype${ID} 82540EM	--nicpromisc${ID} allow-all	--nat-network${ID} ${VM_NAT_NETWORK}
	ID="2"
	VBoxManage modifyvm ${vm_name} --nic${ID} bridged		--nictype${ID} 82540EM	--nicpromisc${ID} allow-all	--bridgeadapter${ID} eno1
done

tree ${VM_LOCATION}/${VM_GROUP}