# Notes

The **default Namespace** contains the objects and resources created by administrators and developers, and objects are assigned to it by default unless another Namespace name is provided by the user.

The **kube-system Namespace** contains the objects created by the Kubernetes system, mostly the control plane agents.

The **kube-public** is a special Namespace, which is unsecured and readable by anyone, used for special purposes such as exposing public (non-sensitive) information about the cluster.

The newest Namespace is **kube-node-lease** which holds node lease objects used for node heartbeat data.

Good practice, however, is to create additional Namespaces, as desired, to virtualize the cluster and isolate users, developer teams, applications, or tiers


------------------

Pods
ReplicaSets
Deployments
DaemonSets