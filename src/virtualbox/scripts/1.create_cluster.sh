#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/virtualbox/scripts/_configs.sh

[ ! -d "${VM_LOCATION}" ] && echo "FOLDER ${VM_LOCATION} DOES NOT EXISTS, created" && mkdir -p ${VM_LOCATION} || echo "FOLDER ${VM_LOCATION} EXISTS"

[ $(VBoxManage natnetwork list ${VM_NAT_NETWORK} | wc -l) == 3 ] && \
	VBoxManage natnetwork add --netname ${VM_NAT_NETWORK} --network "10.0.2.0/24" --enable --dhcp on && \
	VBoxManage natnetwork start --netname ${VM_NAT_NETWORK}

VBoxManage natnetwork list ${VM_NAT_NETWORK}

for i in $(seq ${VM_COUNT}); do
	echo "---"

	vm_name="k8s_node_${i}"
	vm_disk="${VM_LOCATION}/${VM_GROUP}/${vm_name}/${vm_name}.vdi"

	if [ $(VBoxManage list runningvms | grep ${vm_name} | wc -l) == "1" ]; then
		echo "RUNNING ${vm_name}"
		continue
	fi

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

	# ##################################
	# General Settings
	VBoxManage modifyvm ${vm_name} \
		--clipboard-mode bidirectional \
		--draganddrop bidirectional

	echo " |- Modified Settings"

	# ##################################
	# System Settings
	cores=3
	ram=$((8 * 1024))

	VBoxManage modifyvm ${vm_name} \
		--ioapic on \
		--pae on \
		--chipset piix3 \
		--memory ${ram} \
		--cpus ${cores} \
		--cpuexecutioncap 100 \
		--rtcuseutc on \
		--nested-hw-virt on

	echo " |- Modified Specs"

	VBoxManage modifyvm ${vm_name} \
		--boot1 dvd \
		--boot2 disk \
		--boot3 none \
		--boot4 none

	echo " |- Modified Boot order"


	# ##################################
	# Display Settings
	VBoxManage modifyvm ${vm_name} --vram 16 --graphicscontroller vmsvga
	VBoxManage modifyvm ${vm_name} --vrde on

	echo " |- Modified Display Settings"

	# ##################################
	# Storage Settings
	if [ $(VBoxManage list hdds -s | grep "${vm_disk}" | wc -l) == "0" ]; then
		echo "Disk ${vm_disk} | CREATING"
		VBoxManage createhd --filename ${vm_disk} --size 10240 --format VDI

		echo " |- Creating HDD"
	fi


	# ##################################
	# SATA
	VBoxManage storageattach ${vm_name} --storagectl "SATA" --port 0 --device 0 --type hdd --medium ${vm_disk}
	echo " |- Attaching Storage"

	# ##################################
	# Audio Settings
	VBoxManage modifyvm ${vm_name} --audio none
	echo " |- Modified Audio"

	# ##################################
	# Network Settings
	ID="1"
	VBoxManage modifyvm ${vm_name} --nic${ID} natnetwork	--nictype${ID} 82540EM	--nicpromisc${ID} allow-all	--nat-network${ID} ${VM_NAT_NETWORK}
	ID="2"
	VBoxManage modifyvm ${vm_name} --nic${ID} bridged		--nictype${ID} 82540EM	--nicpromisc${ID} allow-all	--bridgeadapter${ID} eno1
	echo " |- Modified network"

	# ##################################
	# Share Folder Settings
	if [ "$(VBoxManage showvminfo ${vm_name} | grep 'Host path' | wc -l)" != 0 ]; then
		VBoxManage sharedfolder remove ${vm_name} --name="k8s"
	fi

	VBoxManage sharedfolder add ${vm_name} \
		--name="k8s" \
		--hostpath="${ROOT_SCRIPT_PATH}" \
		--automount \
		--auto-mount-point="/opt/k8s"
	echo " |- Modified share folder"

done

tree ${VM_LOCATION}/${VM_GROUP}
du -h ${VM_LOCATION}/${VM_GROUP}