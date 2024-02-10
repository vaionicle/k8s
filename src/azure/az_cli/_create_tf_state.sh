#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/az_cli/_config.sh


# Create resource group
az group create \
    --name ${RG_TF_STATE} \
    --location ${LOCATION}

# Create storage account
az storage account create \
    --resource-group ${RG_TF_STATE} \
    --name ${STORAGE_ACCOUNT_NAME} \
    --sku ${INSTANCE_DISK_SKU} \
    --encryption-services blob

# Create blob container
az storage container create \
    --name ${CONTAINER_NAME} \
    --account-name ${STORAGE_ACCOUNT_NAME}