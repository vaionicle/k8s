#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../" && pwd)

. ${ROOT_SCRIPT_PATH}/src/azure/_config.sh

# CREATE RESOURCE GROUP
echo "--- CREATE RESOURCE GROUP"
az group create --name ${RG} --location ${LOCATION} --tags ${TAGS}
