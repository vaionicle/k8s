#!/bin/bash

# https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli#4-sign-in-using-a-service-principal
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
# https://jiasli.github.io/azure-notes/aad/Service-Principal-portal.html

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/_config.sh

az account list -o json | jq
az ad sp list | jq -c '.[] | {"appID": .appId, "appDisplayName": .appDisplayName}'

az ad sp create-for-rbac \
  --only-show-errors \
  --name "${RG}ServicePrincipal" > ${JSON_FILE}

echo "Service Principal File"
cat ${JSON_FILE} | jq

echo "WARNING:"
echo "Go to your subscription with ID ${SUBSCRIPTION_ID}"
echo "And add the Contributor role into '${RG}ServicePrincipal' ServicePrincipal account"