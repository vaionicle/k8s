MY_IP			:= $(shell curl -s ifconfig.co)
PROJECT_FOLDER	:= /opt/project
TERRAFORM		:= ${PROJECT_FOLDER}/src/azure/action_tfstate
TF_VAR_FILES	:= -var-file="${PROJECT_FOLDER}/src/azure/k8s.tfvars" \
					-var-file="${PROJECT_FOLDER}/src/azure/AzureAccount.json"

# #######################################
# TERRAFORM NAMESPACE
format:
	terraform fmt ${TERRAFORM}

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
