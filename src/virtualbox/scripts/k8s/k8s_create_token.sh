echo "Node"

cat /etc/hosts | grep k8scp

TOKEN=$(sudo kubeadm create token)
HASH=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | \
    openssl rsa -pubin -outform der 2>/dev/null | \
    openssl dgst -sha256 -hex | \
    sed 's/ˆ.* //'| \
    awk '{print $2}')
CERT_KEY=$()


echo "JOIN COMMAND FOR WORKER NODE"
echo "kubeadm join --token ${TOKEN} k8scp:6443 --discovery-token-ca-cert-hash sha256:${HASH}"


echo "JOIN COMMAND FOR CONTROL-PLANE NODE"
echo "kubeadm join --token ${TOKEN} k8scp:6443 --discovery-token-ca-cert-hash sha256:${HASH} --control-plane --certificate-key ${CERT_KEY}"