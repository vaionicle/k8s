#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/az_cli/_config.sh
. ${ROOT_SCRIPT_PATH}/src/azure/az_cli/01.login.sh

echo "--- ASSIGN PRIVATE NSG RULES WITH NETWORK"
az network vnet subnet update \
    --resource-group "${RG}" \
    --name "${PRIVATE_NET}.subnet" \
    --vnet-name "${PRIVATE_NET}" \
    --network-security-group "${PRIVATE_NET}.nsg"
