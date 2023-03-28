
## GET PODS

kubectl get pods
kubectl get po

kubectl run pod-hello --image pbitty/hello-from:latest --port 80 --expose true



kubectl create deployment dev-web --image=nginx:1.13.7-alpine
kubectl scale deploy/dev-web --replicas=4




kubectl create deploy ghost --image=ghost
kubectl annotate deployment/ghost kubernetes.io/change-cause="kubectl create deploy ghost --image=ghost"
kubectl get deployments ghost -o yaml
kubectl set image deployment/ghost ghost=ghost:09 --all
kubectl get pods
kubectl rollout undo deployment/ghost
kubectl get pods

kubectl rollout pause deployment/ghost
kubectl rollout resume deployment/ghost