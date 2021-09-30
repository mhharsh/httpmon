#!/bin/bash
source ./base.sh

echo "Starting deployment of grafana"

echo "Uninstalling existing grafana"
helm uninstall grafana

echo "Installing grafana using helm charts"
cd $devopsDir && helm install  grafana bitnami/grafana -f grafana-values.yml > /dev/null

echo "Showing grafana admin login password"
echo "$(kubectl get secret grafana-admin --namespace default -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"

echo "Waiting for deployment"
sleep 60

echo "Forwading grafana port"
kill -9 `lsof -t -i:3000` > /dev/null
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace default port-forward $POD_NAME 3000 &

echo "ACCESS GRAFANA at: \"http://localhost:3000\""
