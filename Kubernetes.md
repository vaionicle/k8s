# Kubernetes K8S

## Table of content

- [Kubernetes K8S](#kubernetes-k8s)
  - [Table of content](#table-of-content)
  - [Kinds](#kinds)
  - [On Control Plane Components](#on-control-plane-components)
    - [kube-apiserver](#kube-apiserver)
    - [kube-scheduler](#kube-scheduler)
    - [kube-controller-manager](#kube-controller-manager)
    - [cloud-controller-manager](#cloud-controller-manager)
    - [etcd](#etcd)
  - [On Nodes](#on-nodes)
    - [kubelet](#kubelet)
    - [kube-proxy](#kube-proxy)
    - [Container runtime](#container-runtime)
  - [Shorcuts](#shorcuts)
  - [Useful Links](#useful-links)

## Kinds

- Services https://kubernetes.io/docs/concepts/services-networking/service/
  - LoadBalancer
  - ClusterIP
  - NodePort https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
- Pods

## On Control Plane Components

### kube-apiserver

### kube-scheduler

### kube-controller-manager

### cloud-controller-manager

### etcd

## On Nodes

### kubelet

### kube-proxy

- Each cluster node runs a daemon called kube-proxy.
- A node agent that watches the API server on the master node for the **addition**, **updates**, and **removal** of **Services and endpoints**.

- kube-proxy is **responsible** for implementing the **Service configuration** on behalf of an administrator or developer, in order to **enable traffic routing** to an exposed application running in Pods.

> Example

For each new Service, on each node, kube-proxy configures iptables rules to capture the traffic for its ClusterIP and forwards it to one of the Service's endpoints. Therefore any node can receive the external traffic and then route it internally in the cluster based on the iptables rules. When the Service is removed, kube-proxy removes the corresponding iptables rules on all nodes as well.

### Container runtime

## Shorcuts

- componentstatuses = cs
- configmaps = cm
- endpoints = ep
- events = ev
- limitranges = limits
- namespaces = ns
- nodes = no
- persistentvolumeclaims = pvc
- persistentvolumes = pv
- pods = po
- replicationcontrollers = rc
- resourcequotas = quota
- serviceaccounts = sa
- services = svc
- customresourcedefinitions = crd, crds
- daemonsets = ds
- deployments = deploy
- replicasets = rs
- statefulsets = sts
- horizontalpodautoscalers = hpa
- cronjobs = cj
- certificiaterequests = cr, crs
- certificates = cert, certs
- certificatesigningrequests = csr
- ingresses = ing
- networkpolicies = netpol
- podsecuritypolicies = psp
- replicasets = rs
- scheduledscalers = ss
- priorityclasses = pc
- storageclasses = sc

## Useful Links

https://kubernetes.io/docs/concepts/overview/components/
https://medium.com/swlh/maximize-your-kubectl-productivity-with-shortcut-names-for-kubernetes-resources-f017303d95e2