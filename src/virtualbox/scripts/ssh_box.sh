#/bin/bash

path=$(readlink -f "${BASH_SOURCE:-$0}")
DIR_PATH=$(dirname $path)
ROOT_SCRIPT_PATH=$(cd "$DIR_PATH/../../../" && pwd)

NODE=${1:-""}
if [ "${NODE}" == "" ]; then
    echo "NODE is not set"
    echo "$ROOT_SCRIPT_PATH/src/virtualbox/scripts/ssh_box.sh 1..N"
    return
fi

. ${ROOT_SCRIPT_PATH}/src/virtualbox/scripts/_configs.sh

BOX_IP=$(cat ${IP_FILE} | tail -n 1 | awk -F "/" '{print $1}')

echo "Username: $username"
echp "Password: $password"
ssh $username@$BOX_IP

# echo "krdc rdp://$BOX_IP:3389"
