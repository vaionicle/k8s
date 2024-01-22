#!/bin/bash

# https://docs.microsoft.com/en-us/cli/azure/network/vnet?view=azure-cli-latest 

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/_config.sh

# LOGIN

echo "--- LOGIN"

if [ "${APP_ID}" != "" ] && [ "${PASSWORD}" != "" ]; then
    echo " |- SP with tenant appID and password"
    az login --service-principal --tenant ${TENANT_ID} -u ${APP_ID} -p ${PASSWORD}
else
    echo " |- SP with tenant"
    az login --service-principal --tenant ${TENANT_ID}
fi