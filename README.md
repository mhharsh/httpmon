# HTTPMON


HTTPMON repo is designed to monitor Prometheus metrics API from external service in a k8s cluster in Prometheus.

### Architecture


![Diagram](https://github.com/mhharsh/httpmon/blob/master/httpmon_architecture.png)

  - Type some Markdown on the left
  - See HTML in the right
  - Magic

### Deployment
The deployment of httpmon has been tested on minikube.Please ensure you have the following things setup before proceeding:
- Kubeconfig is properly configured and you are able to access the kubernetes cluster
- Helm  is installed where the setup is run
- The repo is cloned in the system

Running the below command should get the complete stack up.

```
$ ./stack.sh
```

Sample Output Logs:

```
(httpmon) ➜  httpmon git:(master) ./stack.sh
Starting deployment of prometheus
Adding Bitnami helm repos
Updating helm charts
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "grafana" chart repository
...Successfully got an update from the "stable" chart repository
...Successfully got an update from the "gitlab" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈ Happy Helming!⎈
Uninstalling existing prometheus
release "prometheus" uninstalled
Installing prometheus using helm charts
Waiting for deployment
E0930 10:18:49.688773    4512 portforward.go:340] error creating error stream for port 3000 -> 3000: Timeout occured
E0930 10:18:49.946863    4512 portforward.go:340] error creating error stream for port 3000 -> 3000: Timeout occured
Handling connection for 3000
E0930 10:19:19.949447    4512 portforward.go:340] error creating error stream for port 3000 -> 3000: Timeout occured
Handling connection for 3000
Handling connection for 3000
Handling connection for 8000
E0930 10:19:20.985908    4512 portforward.go:400] an error occurred forwarding 3000 -> 3000: error forwarding port 3000 to pod f1498e9afe92f0f02bb03ea7b85d20f9dc0ca3afa1dbb1bb64a5479b63488ee3, uid : container not running (f1498e9afe92f0f02bb03ea7b85d20f9dc0ca3afa1dbb1bb64a5479b63488ee3)

Forwading prometheus port
ACCESS PROMETHEUS at: "http://localhost:9090"
Starting deployment of grafana
Uninstalling existing grafana
Forwarding from 127.0.0.1:9090 -> 9090
Forwarding from [::1]:9090 -> 9090
release "grafana" uninstalled
Installing grafana using helm charts
Showing grafana admin login password
h1aKwn2LKC
Waiting for deployment
E0930 10:19:50.982369    4512 portforward.go:340] error creating error stream for port 3000 -> 3000: Timeout occured
Handling connection for 3000
E0930 10:20:20.987807    4512 portforward.go:340] error creating error stream for port 3000 -> 3000: Timeout occured
Handling connection for 3000
Handling connection for 3000
Handling connection for 8000
Forwading grafana port
ACCESS GRAFANA at: "http://localhost:3000"
Setting k8s to use local docker registry
Forwarding from 127.0.0.1:3000 -> 3000
Forwarding from [::1]:3000 -> 3000
Starting deployment of webappp
Error response from daemon: conflict: unable to remove repository reference "webapp" (must force) - container f96043878875 is using its referenced image 9ee07f4c2d3a
Deleting app
Setting app on k8s
Waiting for app to come up
Exposing webapp port
Creating service monitor
servicemonitor.monitoring.coreos.com "webapp-monitoring" deleted
Forwarding from 127.0.0.1:8000 -> 8000
Forwarding from [::1]:8000 -> 8000
servicemonitor.monitoring.coreos.com/webapp-monitoring created
ACCESS WEBAPP at: "http://localhost:8000"
```
### Configuring Grafana
Login to grafana using : http://localhost:3000.
- username: admin
- pasword: <displayed during stack installation>(See above logs : Showing grafana admin login password h1aKwn2LKC)

Add prometheus as data source with service url as: http://prometheus-kube-prometheus-prometheus.default.svc.cluster.local:9090

Create dashboard.

![Grafana Metrics Dashboard](https://github.com/mhharsh/httpmon/blob/master/grafana_dashboard.png)

