#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/az_cli/_config.sh
. ${ROOT_SCRIPT_PATH}/src/azure/az_cli/01.login.sh

# CREATE NETWORK
echo "--- CREATE PRIVATE VNET"

az network vnet create \
  --name "${PRIVATE_NET}.net" \
  --resource-group "${RG}" \
  --address-prefixes 10.0.0.0/16 \
  --subnet-name "${PRIVATE_NET}.subnet" \
  --subnet-prefixes 10.0.0.0/24

# echo "--- CREATE PUBLIC IP"
# az network public-ip create \
#   --name "${PUBLIC_NET}" \
#   --resource-group "${RG}" \
#   --allocation-method "Static"
