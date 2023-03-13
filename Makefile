cluster:
	./src/scripts/create_cluster.sh

ubuntu:
ifdef node
	./src/scripts/install_ubuntu.sh ${node}
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
	./src/scripts/drop_cluster.sh


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