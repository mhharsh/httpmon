#!/bin/bash
source ./base.sh

echo "Setting k8s to use local docker registry"
eval $(minikube -p minikube docker-env) > /dev/null


echo "Starting deployment of webappp"
cd $appDir && docker image rm webapp
cd $appDir && docker build -t webapp . > /dev/null


echo "Deleting app"
cd $devopsDir && kubectl delete -f webapp.yml > /dev/null


echo "Setting app on k8s"
cd $devopsDir && kubectl apply -f webapp.yml > /dev/null

echo "Waiting for app to come up"
sleep 60

echo "Exposing webapp port"
kill -9 `lsof -t -i:8000`
kubectl port-forward --namespace default svc/webapp-service 8000:8000 & > /dev/null

echo "Creating service monitor"
cd $devopsDir && kubectl delete -f webapp-servicemonitor.yml
cd $devopsDir && kubectl apply -f webapp-servicemonitor.yml

echo "ACCESS WEBAPP at: \"http://localhost:8000\""
