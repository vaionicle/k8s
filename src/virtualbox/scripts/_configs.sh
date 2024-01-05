#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

VM_GROUP="k8s"
VM_LOCATION="/opt/VirtualBox"
VM_NAT_NETWORK="k8s"
VM_COUNT=4

VM_NAME="k8s_node_${NODE}"
HOSTNAME_NAME="k8snode${NODE}"

ISO_VERSION="22.04.1"
ISO_FILE="ubuntu-${ISO_VERSION}-live-server-amd64.iso"

CONFIGS_PATH="$ROOT_SCRIPT_PATH/src/virtualbox/configs"
IP_FILE="${ROOT_SCRIPT_PATH}/src/virtualbox/${HOSTNAME_NAME}.network.txt"

username="user"
password="ubuntu"
