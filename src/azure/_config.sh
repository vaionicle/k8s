#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../" && pwd)

[ -f "${ROOT_SCRIPT_PATH}/src/azure/_az.sh" ] && . ${ROOT_SCRIPT_PATH}/src/azure/_az.sh

export RG="k8s"
export A_USER="vaionicle"

export JSON_FILE="sp${RG}.json"
export AZURE_ACCOUNT="AzureAccount.json"

export APP_ID=$(cat ${JSON_FILE} | jq -r ".appId")
export PASSWORD=$(cat ${JSON_FILE} | jq -r ".password")
export LOCATION="uksouth" # uksouth,ukwest
export TAGS="project=${RG}"

export IMAGE_ID="Canonical:0001-com-ubuntu-server-focal:20_04-lts-gen2:latest"

export INSTANCE_SIZE="Standard_B1s"
export INSTANCE_DISK_SKU="Standard_LRS" # Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS, Premium_ZRS, StandardSSD_ZRS, PremiumV2_LRS

export PRIVATE_NET="k8s.private"
export PUBLIC_NET="k8s.public"

echo "-- CONFIG LOADED --"