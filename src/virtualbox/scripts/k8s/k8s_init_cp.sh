#/bin/bash

echo "Control Panel"

cat <<EOF | tee kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: 1.25.16
controlPlaneEndpoint: "k8scp:6443"
networking:
  podSubnet: 192.168.0.0/16
EOF

kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.out

openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | \
    openssl rsa -pubin -outform der 2>/dev/null | \
    openssl dgst -sha256 -hex | \
    sed 's/ˆ.* //'


# sudo cp /etc/kubernetes/admin.conf HOME/ sudo chown (id -u):$(id -g) $HOME/admin.conf
# export KUBECONFIG=$HOME/admin.conf