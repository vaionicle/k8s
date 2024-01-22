#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/_config.sh

# CREATE RESOURCE GROUP
echo "--- CREATE RESOURCE GROUP"
az group create --name ${RG} --location ${LOCATION} --tags ${TAGS}

# CREATE NETWORK
echo "--- CREATE PRIVATE VNET"
az network vnet create \
  --name "${PRIVATE_NET}.net" \
  --resource-group "${RG}" \
  --address-prefixes 10.0.0.0/16 \
  --subnet-name "${PRIVATE_NET}.subnet" \
  --subnet-prefixes 10.0.0.0/24

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

az network nsg rule create \
    --resource-group "${RG}" \
    --name "${PRIVATE_NET}.rule.web" \
    --nsg-name "${PRIVATE_NET}.nsg" \
    --protocol tcp \
    --priority 1001 \
    --destination-port-range 6443 \
    --access allow

echo "--- CREATE PRIVATE NSG RULES"
az network vnet subnet update \
    --resource-group "${RG}" \
    --name "${PRIVATE_NET}.subnet" \
    --vnet-name "${PRIVATE_NET}" \
    --network-security-group "${PRIVATE_NET}.nsg"


# echo "--- CREATE PUBLIC IP"
# az network public-ip create \
#   --name "${PUBLIC_NET}" \
#   --resource-group "${RG}" \
#   --allocation-method "Static"
