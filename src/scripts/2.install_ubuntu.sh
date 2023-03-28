#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../" && pwd)

NODE=${1:-""}
if [ "${NODE}" == "" ]; then
    echo "NODE ID is not set"
    echo "$ROOT_SCRIPT_PATH/src/scripts/install_ubuntu.sh 1..N"
    return
fi

VM_NAME="k8s_node_${NODE}"
VM_GROUP="k8s"
VM_LOCATION="/opt/VirtualBox"

ISO_VERSION="22.04.1"
ISO_FILE="ubuntu-${ISO_VERSION}-live-server-amd64.iso"

CONFIGS_PATH=$ROOT_SCRIPT_PATH/src/configs

username="user"
password="ubuntu"

[ ! -f "$ROOT_SCRIPT_PATH/$ISO_FILE" ] && wget https://releases.ubuntu.com/${ISO_VERSION}/${ISO_FILE} -O "$ROOT_SCRIPT_PATH/$ISO_FILE"
[ -f "$ROOT_SCRIPT_PATH/seed_$NODE.iso" ] && rm -rf "seed_$NODE.iso"
[ -f "$CONFIGS_PATH/user-data" ] && rm -rf $CONFIGS_PATH/user-data

cp $ROOT_SCRIPT_PATH/src/scripts/user-data-template $CONFIGS_PATH/user-data

# GENERATE_PASS="$(openssl passwd -6 -stdin <<< ${password})"
# echo $GENERATE_PASS
# sed -i 's/##PWD##/${GENERATE_PASS}/g' $CONFIGS_PATH/user-data

sed -i "s/##HOSTNAME##/k8snode${NODE}/g" $CONFIGS_PATH/user-data
sed -i "s/##REALNAME##/k8s_node_${NODE}/g" $CONFIGS_PATH/user-data
sed -i "s/##USERNAME##/${username}/g" $CONFIGS_PATH/user-data

touch  $CONFIGS_PATH/meta-data

mkisofs -JR -V cidata -o $ROOT_SCRIPT_PATH/seed_$NODE.iso $CONFIGS_PATH

DESC=$'username: user\npassword: '${password}$'\nhostname: k8snode'"${NODE}"
VBoxManage modifyvm $VM_NAME --description "$(echo "$DESC")"

VBoxManage storageattach $VM_NAME --storagectl "SATA" --port 1 --device 0 --type dvddrive --medium "$ROOT_SCRIPT_PATH/${ISO_FILE}"
VBoxManage storageattach $VM_NAME --storagectl "SATA" --port 2 --device 0 --type dvddrive --medium "$ROOT_SCRIPT_PATH/seed_${NODE}.iso"

VBoxManage startvm $VM_NAME --type=gui

tree ${VM_LOCATION}/${VM_GROUP}
du -h ${VM_LOCATION}/${VM_GROUP}