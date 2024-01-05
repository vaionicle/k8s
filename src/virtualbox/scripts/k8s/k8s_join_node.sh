echo "Node"

cat /etc/hosts | grep k8scp

TOKEN="27eee4.6e66ff60318da929"
CA_CERT_HASH="6d541678b05652e1fa5d43908e75e67376e994c3483d6683f2a18673e5d2a1b0"

kubeadm join --token ${TOKEN} k8scp:6443 --discovery-token-ca-cert-hash sha256:${CA_CERT_HASH}

