cluster:
	./src/scripts/create_cluster.sh

ubuntu:
ifdef node
	./src/scripts/install_ubuntu.sh ${node}
else
	@echo "NEED TO SPECIFY NODE NUMBER"
	@echo "make ubuntu node=1"
endif
