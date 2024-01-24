IMAGE_NAME := cka-k8s:latest
USER_ID    := $(shell id -u ${USER})
GROUP_ID   := $(shell id -g ${USER})
MY_IP      := $(shell curl -s ifconfig.co)

USER            := ${HOME}
PROJECT_FOLDER  := /opt/project
DOCKER_RUN      := docker run -it --rm \
	-v ${PWD}/user/.azure:/home/user/.azure/ \
	-v ${PWD}/user/.ssh:/home/user/.ssh/ \
	-v ${PWD}/:${PROJECT_FOLDER} \
	-u "${USER_ID}:${GROUP_ID}" \
	-w "${PROJECT_FOLDER}" \
	${IMAGE_NAME}

init.folders:
	mkdir -p ${PWD}/user/.azure
	mkdir -p ${PWD}/user/.ssh

build:
	docker build \
		--build-arg UID="${USER_ID}" \
		--build-arg GID="${GROUP_ID}" \
		-f ${PWD}/docker/Dockerfile.alpine \
		-t ${IMAGE_NAME} \
		.

ssh: init.folders
	${DOCKER_RUN} /bin/bash

ssh.cp: init.folders
	${DOCKER_RUN} ssh cp

ssh.node1: init.folders
	${DOCKER_RUN} ssh node1

ssh.node2: init.folders
	${DOCKER_RUN} ssh node2

# ##################################
# Virtual Box
vb.cluster:
	./src/virtualbox/scripts/1.create_cluster.sh

vb.install_ubuntu:
ifdef node
	./src/virtualbox/scripts/2.install_ubuntu.sh ${node}
else
	@echo "NEED TO SPECIFY NODE NUMBER"
	@echo "make ubuntu node=1"
endif


vb.start:
ifdef node
	VBoxManage startvm k8s_node_${node} --type=headless
else
	@echo "NEED TO SPECIFY NODE NUMBER"
	@echo "make start node=1"
endif

vb.drop:
	./src/virtualbox/scripts/4.drop_cluster.sh

vb.vms.list:
	VBoxManage list runningvms
vb.vm.info:
	VBoxManage showvminfo k8s_node_${node}

# ##################################
# Minikube
minikube:
	minikube start \
		--driver=virtualbox \
		--nodes=3 \
		--disk-size=10g \
		--cpus=2 \
		--memory=4g \
		--kubernetes-version=v1.25.1 \
		--cni=calico \
		--container-runtime=cri-o \
		-p multivbox


# #######################################
# AZURE NAMESPACE

az.docker:
	docker run -it --rm \
		-v ${PWD}:/opt/project \
		-v ${HOME}/.ssh:/root/.ssh \
		-v ${HOME}/.azure:/root/.azure \
		mcr.microsoft.com/azure-cli:latest

az.install:
	pip3 install azure-cli

az.show_sp:
	az ad sp list | jq '.[] | {"appDisplayName": .appDisplayName, "appID": .appId}'

az.accounts:
	az account list -o json | jq

az.clean_cache:
	az cache purge

az.allow_my_ip:
	az network nsg rule update \
		--nsg-name backend.nsg \
		-g k8sCkaTerraform \
		-n backend.nsg.22 \
		--source-address-prefixes "$(MY_IP)" | jq
