# Minikube CMD

minikube start

minikube stop

minikube profile

minikube profile list

-------------------------------

## Start a cluster

### PODMAN
- minikube start \
  --kubernetes-version=v1.23.3 \
  --driver=podman --profile minipod

### DOCKER
- minikube start \
    --kubernetes-version=v1.24.4 \
    --nodes=2 --driver=docker --profile doubledocker

- minikube start \
    --kubernetes-version=v1.25.3 \
    --nodes=2 --driver=docker --profile doubledocker

- minikube start \
    --kubernetes-version="1.25.4" \
    --driver=docker --cpus=6 --memory=8g -p largedock

### VIRTUAL BOX

- minikube start \
    --kubernetes-version=v1.25.3 \
    --driver=virtualbox --nodes=3 --disk-size=10g \
    --cpus=2 --memory=4g --cni=calico \
    --container-runtime=cri-o -p mitsos

- minikube start \
  --driver=virtualbox -n 3 --container-runtime=containerd \
  --cni=calico -p minibox


## Node List

minikube node list
minikube node list -p minibox
minikube node list -p doubledocker


## Set default profile
minikube profile doubledocker

## Install
q

source <(minikube completion bash)