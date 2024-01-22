cluster:
	./src/virtualbox/scripts/1.create_cluster.sh

ubuntu:
ifdef node
	./src/virtualbox/scripts/2.install_ubuntu.sh ${node}
else
	@echo "NEED TO SPECIFY NODE NUMBER"
	@echo "make ubuntu node=1"
endif


start:
ifdef node
	VBoxManage startvm k8s_node_${node} --type=headless
else
	@echo "NEED TO SPECIFY NODE NUMBER"
	@echo "make start node=1"
endif

drop:
	./src/virtualbox/scripts/4.drop_cluster.sh

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

vms.list:
	VBoxManage list runningvms
vm.info:
	VBoxManage showvminfo k8s_node_${node}

# #######################################
# AZURE NAMESPACE
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
		-g FetchLegalTerraform \
		-n backend.nsg.22 \
		--source-address-prefixes "$(MY_IP)" | jq