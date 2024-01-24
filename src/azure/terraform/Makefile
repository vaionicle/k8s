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

# generate_keys.cp:
# 	cd ${TERRAFORM} && \
# 	( terraform output -json vm_cp | jq -r .tls_private_key > ~/.ssh/k8s_cp.id_rsa ) && \
# 	( terraform output -json vm_cp | jq -r .tls_public_key > ~/.ssh/k8s_cp.id_rsa.pub ) && \
# 	chmod 600 ~/.ssh/k8s_cp.id_rsa && \
# 	chmod 600 ~/.ssh/k8s_cp.id_rsa.pub

# generate_keys.node1:
# 	cd ${TERRAFORM} && \
# 	( terraform output -json vm_node_1 | jq -r .tls_private_key > ~/.ssh/node_1.id_rsa ) && \
# 	( terraform output -json vm_node_1 | jq -r .tls_public_key > ~/.ssh/node_1.id_rsa.pub ) && \
# 	chmod 600 ~/.ssh/node_1.id_rsa && \
# 	chmod 600 ~/.ssh/node_1.id_rsa.pub

# generate_keys.node2:
# 	cd ${TERRAFORM} && \
# 	( terraform output -json vm_node_2 | jq -r .tls_private_key > ~/.ssh/node_2.id_rsa ) && \
# 	( terraform output -json vm_node_2 | jq -r .tls_public_key > ~/.ssh/node_2.id_rsa.pub ) && \
# 	chmod 600 ~/.ssh/node_2.id_rsa && \
# 	chmod 600 ~/.ssh/node_2.id_rsa.pub