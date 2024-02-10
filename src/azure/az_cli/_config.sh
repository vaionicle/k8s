#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

echo "-- LOADING CONFIG --"

export LOCATION="eastus" #uksouth,ukwest,eastus
export RG="k8s"
export TAGS="project=${RG}"

export RG_TF_STATE="tfstate"
export STORAGE_ACCOUNT_NAME="tfstate${RANDOM}"
export CONTAINER_NAME="tfstate"

export JSON_FILE="sp${RG}.json"
export AZURE_ACCOUNT="AzureAccount.json"

if [ -f "${ROOT_SCRIPT_PATH}/src/azure/${JSON_FILE}" ]; then
    export APP_ID=$(cat "${ROOT_SCRIPT_PATH}/src/azure/${JSON_FILE}" | jq -r ".appId")
    export PASSWORD=$(cat "${ROOT_SCRIPT_PATH}/src/azure/${JSON_FILE}" | jq -r ".password")
fi

export A_USER="vaionicle"

export IMAGE_ID="Canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:latest"

export INSTANCE_SIZE="Standard_B1s"

# Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS, Premium_ZRS, StandardSSD_ZRS, PremiumV2_LRS
export INSTANCE_DISK_SKU="Standard_LRS"

export PRIVATE_NET="k8s.private"
export PUBLIC_NET="k8s.public"

[ -f "${ROOT_SCRIPT_PATH}/src/azure/az_cli/_az.sh" ] && \
    . ${ROOT_SCRIPT_PATH}/src/azure/az_cli/_az.sh

echo "-- DONE --"
