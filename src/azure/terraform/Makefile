MY_IP           := $(shell curl -s ifconfig.co)
PROJECT_FOLDER	:= /opt/project
TERRAFORM		:= ${PROJECT_FOLDER}/src/azure/terraform
TF_VAR_FILES    := -var 'my_public_ip=${MY_IP}' \
					-var-file="${PROJECT_FOLDER}/src/azure/k8s.tfvars" \
					-var-file="${PROJECT_FOLDER}/src/azure/AzureAccount.json"

# #######################################
# TERRAFORM NAMESPACE
format:
	terraform fmt ${TERRAFORM}
	terraform fmt ${TERRAFORM}/vm

init:
	terraform init -upgrade

validate:
	terraform validate

plan:
	terraform plan ${TF_VAR_FILES}

apply:
	terraform apply ${TF_VAR_FILES} -auto-approve

destroy:
	terraform destroy ${TF_VAR_FILES} -auto-approve

tf: format init validate apply

upload:
	@echo "cp"
	rsync -avz ${PROJECT_FOLDER}/src/virtualbox/scripts/installations/ cp:/home/azureuser/scripts/
	rsync -avz ${PROJECT_FOLDER}/src/virtualbox/scripts/k8s/ cp:/home/azureuser/scripts/
	@echo "node1"
	rsync -avz ${PROJECT_FOLDER}/src/virtualbox/scripts/installations/ node1:/home/azureuser/scripts/
	rsync -avz ${PROJECT_FOLDER}/src/virtualbox/scripts/k8s/ node1:/home/azureuser/scripts/
	@echo "node2"
	rsync -avz ${PROJECT_FOLDER}/src/virtualbox/scripts/installations/ node2:/home/azureuser/scripts/
	rsync -avz ${PROJECT_FOLDER}/src/virtualbox/scripts/k8s/ node2:/home/azureuser/scripts/
	@echo "node3"
	rsync -avz ${PROJECT_FOLDER}/src/virtualbox/scripts/installations/ node3:/home/azureuser/scripts/
	rsync -avz ${PROJECT_FOLDER}/src/virtualbox/scripts/k8s/ node3:/home/azureuser/scripts/
