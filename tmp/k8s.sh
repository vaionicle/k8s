#!/bin/bash


# ----------------------------------------
# init system

sudo -i

apt-get update && apt-get upgrade -y

apt install -y vim nano tree \
	curl apt-transport-https vim git wget gnupg2 \
	software-properties-common lsb-release ca-certificates uidmap

apt autoremove
apt autoclean

swapoff -a

modprobe overlay
modprobe br_netfilter

cat << EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system


mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update &&  apt-get install containerd.io -y
containerd config default | tee /etc/containerd/config.toml
sed -e 's/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml
systemctl restart containerd


echo "deb  http://apt.kubernetes.io/  kubernetes-xenial  main" | tee -a /etc/apt/sources.list.d/kubernetes.list

curl -s \
       https://packages.cloud.google.com/apt/doc/apt-key.gpg \
       | apt-key add -

apt-get update
apt-get install -y kubeadm=1.26.2-00 kubelet=1.26.2-00 kubectl=1.26.2-00
apt-mark hold kubelet kubeadm kubectl



---------------------------------------------------------------------------

wget https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

k8s_ip=$(hostname -I | awk '{print $1}')
echo "${k8s_ip} k8scp" | sudo tee -a /etc/hosts

sudo kubeadm reset

cat << EOF | tee $HOME/k8s/kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: 1.26.2
controlPlaneEndpoint: "k8scp:6443"
networking:
  podSubnet: 192.168.0.0/16
EOF

kubeadm init \
	--config=$HOME/k8s/kubeadm-config.yaml \
	--upload-certs | tee kubeadm-init.out


# FOR CP
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
less $HOME/.kube/config

# FOR NODE
sudo cp -i /etc/kubernetes/kubelet.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
less $HOME/.kube/config

# FOR CP
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/ˆ.* //'
sudo kubeadm token create

kubeadm join \
	--token wl7mor.9is40kw124v0sv2q \
	k8scp:6443 \
	--discovery-token-ca-cert-hash \
	sha256:c88a98c3347d1637b2af88b613f6778a8181c196bd1c448412b6dda8a7111572

-------------------------------
cleanup

sudo rm -rf /var/log/journal/*/*.*
sudo rm -rf /swap.img

sudo apt-get autoclean
sudo apt-get autoremove


---------------------------------
cmd

kubectl get nodes

kubectl taint nodes minikube node-role.kubernetes.io/master:NoSchedule




kubectl create deployment nginx --image=nginx

kubectl get deployments

kubectl describe deployments.apps nginx

kubectl events --for Pod/nginx-748c667d99-f5bsl

kubectl get deployment nginx -o yaml

kubectl scale deployment nginx --replicas 3

# ------------------------
# etcd

kubectl -n kube-system exec -it etcd-k8s-control-plane -- sh -c "ETCDCTL_API=3 \
	ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt \
	ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt \
	ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key \
	etcdctl endpoint health"

kubectl -n kube-system exec -it etcd-k8s-control-plane -- sh -c "ETCDCTL_API=3 \
	ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt \
	ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt \
	ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key \
	etcdctl --endpoints=https://127.0.0.1:2379 member list"

kubectl -n kube-system exec -it etcd-k8s-control-plane -- sh -c "ETCDCTL_API=3 \
	ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt \
	ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt \
	ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key \
	etcdctl --endpoints=https://127.0.0.1:2379 member list -w table"

kubectl -n kube-system exec -it etcd-k8s-control-plane -- sh -c "ETCDCTL_API=3 \
	ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt \
	ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt \
	ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key \
	etcdctl --endpoints=https://127.0.0.1:2379 snapshot save /var/lib/etcd/snapshot.db"

mkdir $HOME/backup
sudo cp /var/lib/etcd/snapshot.db $HOME/backup/snapshot.db-$(date +%m-%d-%y)
sudo cp /home/user/k8s/kubeadm-config.yaml $HOME/backup/
sudo cp -r /etc/kubernetes/pki/etcd $HOME/backup/
rm -rf /var/lib/etcd/snapshot.db

#------------------------
# Kinds
- Deployment
- Pod
- ClusterConfiguration
- StatefulSets
- DaemonSets

- svc    ( service )
- ep     ( endpoints )




all	events (ev)
podsecuritypolicies (psp)
certificatesigningrequests (csr)
horizontalpodautoscalers (hpa)
podtemplates
clusterrolebindings	ingresses (ing)
replicasets (rs)
clusterroles	
jobs	
replicationcontrollers (rc)
clusters (valid only for federation apiservers)
limitranges (limits)
resourcequotas (quota)
componentstatuses (cs)
namespaces (ns)
rolebindings
configmaps (cm)
networkpolicies (netpol)
roles
controllerrevisions	nodes (no)
secrets
cronjobs
persistentvolumeclaims (pvc)
serviceaccounts (sa)
customresourcedefinition (crd)
persistentvolumes (pv)
services (svc)
daemonsets (ds)
poddisruptionbudgets (pdb)
statefulsets
deployments (deploy)
podpreset
storageclasses
endpoints (ep)
pods (po)