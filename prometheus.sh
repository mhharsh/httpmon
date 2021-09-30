#!/bin/bash
source ./base.sh

echo "Starting deployment of prometheus"

echo "Adding Bitnami helm repos"
helm repo add bitnami https://charts.bitnami.com/bitnami > /dev/null

echo "Updating helm charts"
helm repo update

echo "Uninstalling existing prometheus"
helm uninstall prometheus

echo "Installing prometheus using helm charts"
cd $devopsDir && helm install prometheus bitnami/kube-prometheus > /dev/null

echo "Waiting for deployment"
sleep 60

echo "Forwading prometheus port"
kill -9 `lsof -t -i:9090`
kubectl port-forward --namespace default svc/prometheus-kube-prometheus-prometheus 9090:9090 & > /dev/null

echo "ACCESS PROMETHEUS at: \"http://localhost:9090\""