#!/bin/bash

# https://docs.microsoft.com/en-us/cli/azure/network/vnet?view=azure-cli-latest 

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/az_cli/_config.sh

echo "--- LOGIN"

echo "TENANT_ID.: ${TENANT_ID}"
echo "APP_ID....: ${APP_ID}"
echo "PASSWORD..: ${PASSWORD}"

if [ "${APP_ID}" == "" ] && [ "${PASSWORD}" == "" ]; then
    echo " |- Login "
    az login  -o table
    az account subscription list  -o table
    az account set --subscription ${SUBSCRIPTION_ID}

elif [ "${APP_ID}" != "" ] && [ "${PASSWORD}" != "" ]; then
    echo " |- ServicePrincipal with tenantID, appID and password"
    az login --service-principal --tenant "${TENANT_ID}" -u "${APP_ID}" -p "${PASSWORD}" -o table
fi