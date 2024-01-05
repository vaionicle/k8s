#/bin/bash

echo "Control Panel"
kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.out

openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | \
    openssl rsa -pubin -outform der 2>/dev/null | \
    openssl dgst -sha256 -hex | \
    sed 's/ˆ.* //'


# sudo cp /etc/kubernetes/admin.conf HOME/ sudo chown (id -u):$(id -g) $HOME/admin.conf
# export KUBECONFIG=$HOME/admin.conf