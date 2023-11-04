# Scenario 1 - Simple Deployment

## What

1. Create a new cluster using minikube with **nodes 3** and **docker driver**
2. Deploy an nginx server
3. Expose nginx server
4. Ensure you get response from nginx
5. Destory the Pods
6. Destory the Cluster

## How

### 1. Create a new cluster using minikube with **nodes 3** and **docker driver**

```bash
# Build Cluster
minikube start --nodes 3 --driver docker --profile "scenario-1"

# Set as the Default cluster
minikube profile scenario-1

# See all the available clusters
minikube profile list

# Use kubectl to get all nodes
kubectl get nodes --all-namespaces
```

### 2. Deploy an nginx server

```bash
# Run nginx image 
kubectl run nginx-1 --image=nginx --port 8989

# View pod running (check if spins)
kubectl get pod

# Describe nginx-1 pod
kubectl describe pod nginx-1
```

```bash
# Create a deployment for nginx
kubectl create deployment nginx-2 --image=nginx

# Describe pod and deployment nginx-2
kubectl describe pod nginx-2
kubectl describe deployments.apps nginx-2

```

```yaml

```

6. Destroy the pods

