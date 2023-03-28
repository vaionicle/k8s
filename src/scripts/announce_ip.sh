#!/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)


IP_FILE="${DIR_PATH}/../$(hostname).network.txt"

echo $DIR_PATH
echo $IP_FILE

touch $IP_FILE
ip addr list | grep inet | grep -v inet6 | grep -v '127.0.0.1' | awk '{print $2}' > "${IP_FILE}"

cat ${IP_FILE}

exit 0