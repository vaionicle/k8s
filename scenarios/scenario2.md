# Scenario 1 - Deploy and replicate pods

## What

1. Create a new cluster using minikube with **nodes 2** and **docker driver**, one cp and one node
3. Deploy 2 instances of wordpress using **RepliceSet**
4. Expose both wordpress pods using **Service**? 
5. Ensure that you get response from wordpress node
6. Destory the Pods
7. Destory the Cluster

## How

1. init cp

```yaml
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: 1.25.16
controlPlaneEndpoint: "k8scp:6443"
networking:
  podSubnet: 192.168.0.0/16
```

### Save output for future review
kubeadm init --config=kubeadm-config.yaml --upload-certs | tee kubeadm-init.out
kubeadm token list