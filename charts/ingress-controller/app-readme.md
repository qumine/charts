QuMine - Ingress
---

Kubernetes ingress controller for routing Minecraft connections based on the requested hostname inside of kubernetes

# Important (Rancher 2.4 and lower)

On Rancher Clusters with only the cluster level monitoring enabled please add the target namespace into the ```prometheus-cluster-monitoring-additional-scrape-configs``` secret.