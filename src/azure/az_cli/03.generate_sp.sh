#!/bin/bash

# https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli#4-sign-in-using-a-service-principal
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
# https://jiasli.github.io/azure-notes/aad/Service-Principal-portal.html

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/az_cli/_config.sh

az account set --subscription="${SUBSCRIPTION_ID}"
az account list -o table
az ad sp list -o table

ROLE_NAME="Contributor"

# --role="${ROLE_NAME}" \
# --scopes="/subscriptions/${SUBSCRIPTION_ID}" \
az ad sp create-for-rbac \
  --only-show-errors \
  --name="${RG}ServicePrincipal" > ${ROOT_SCRIPT_PATH}/src/azure/${JSON_FILE}


echo "Service Principal File"
cat ${ROOT_SCRIPT_PATH}/src/azure/${JSON_FILE} | jq

echo "Service Principal File"
cat ${ROOT_SCRIPT_PATH}/src/azure/${JSON_FILE} | jq "{
  \"azure\": {
    \"subscription_id\": \"${SUBSCRIPTION_ID}\",
    \"client_id\": .appId,
    \"client_secret\": .password,
    \"tenant_id\": .tenant
  }
}" > ${ROOT_SCRIPT_PATH}/src/azure/${AZURE_ACCOUNT}

echo "############################################"
echo "WARNING:"
echo "Go to your subscription with ID ${SUBSCRIPTION_ID}"
echo "And add the ${ROLE_NAME} role into '${RG}ServicePrincipal' ServicePrincipal account"
echo "############################################"