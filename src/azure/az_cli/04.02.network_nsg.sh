#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/az_cli/_config.sh
. ${ROOT_SCRIPT_PATH}/src/azure/az_cli/01.login.sh

echo "--- CREATE PRIVATE NSG"
az network nsg create \
    --resource-group "${RG}" \
    --name "${PRIVATE_NET}.nsg"

echo "--- CREATE PRIVATE NSG RULES"
az network nsg rule create \
    --resource-group "${RG}" \
    --name "${PRIVATE_NET}.rule.ssh" \
    --nsg-name "${PRIVATE_NET}.nsg" \
    --protocol tcp \
    --priority 1000 \
    --destination-port-range 22 \
    --access allow


# https://kubernetes.io/docs/reference/networking/ports-and-protocols/
# 
# Control Plane
# TCP	Inbound	6443	Kubernetes API server	All
# TCP	Inbound	2379-2380	etcd server client API	kube-apiserver, etcd
# TCP	Inbound	10250	Kubelet API	Self, Control plane
# TCP	Inbound	10259	kube-scheduler	Self
# TCP	Inbound	10257	kube-controller-manager	Self

# Worker
# TCP	Inbound	10250	Kubelet API	Self, Control plane
# TCP	Inbound	30000-32767	NodePort Services†	All