# minecraft-server

[QuMine Server Java](https://github.com/qumine/minecraft-server) is a docker container that wrapps the process of starting and upgrading minecraft servers.

## TL;DR

```console
$ helm repo add qumine https://qumine.github.io/charts
$ helm install my-server qumine/minecraft-server
```

## Prerequisites

- Kubernetes 1.12+
- Helm 3.0-beta3+

## Installing the Chart

To install the chart with the release name `my-server`:

```bash
$ helm install my-server qumine/minecraft-server
```

The command deploys qumine-server on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-server` deployment:

```console
$ helm delete my-server
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the minecraft-server chart and their default values.


| Parameter                              | Description                                                                                                                                                                                                     | Default                                                 |
|----------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| `global.imageRegistry`                 | Global Docker image registry                                                                                                                                                                                    | `nil`                                                   |
| `global.imagePullSecrets`              | Global Docker registry secret names as an array                                                                                                                                                                 | `[]` (does not add image pull secrets to deployed pods) |
| `image.registry`                       | QuMine-Server image registry                                                                                                                                                                                    | `docker.io`                                             |
| `image.repository`                     | QuMine-Server Image name                                                                                                                                                                                        | `qumine/minecraft-server`                             |
| `image.tag`                            | QuMine-Server Image tag                                                                                                                                                                                         | `{TAG_NAME}`                                            |
| `image.pullPolicy`                     | QuMine-Server image pull policy                                                                                                                                                                                 | `IfNotPresent`                                          |
| `image.pullSecrets`                    | Specify docker-registry secret names as an array                                                                                                                                                                | `[]` (does not add image pull secrets to deployed pods) |
| `nameOverride`                         | String to partially override qumine.fullname template with a string (will prepend the release name)                                                                                                             | `nil`                                                   |
| `fullnameOverride`                     | String to fully override qumine.fullname template with a string                                                                                                                                                 | `nil`                                                   |
| `extraArgs`                            | Extra arguments to be passed to qumine                                                                                                                                                                          | `{}`                                                    |
| `extraEnv`                             | Extra environment variables to be passed to qumine                                                                                                                                                              | `[]`                                                    |
| `replicas`                             | Desired number of QuMine-Server replicas                                                                                                                                                                        | `1`                                                     |
| `affinity`                             | Affinity for pod assignment (this value is evaluated as a template)                                                                                                                                             | `{}`                                                    |
| `nodeSelector`                         | Node labels for pod assignment (this value is evaluated as a template)                                                                                                                                          | `{}`                                                    |
| `tolerations`                          | Tolerations for pod assignment (this value is evaluated as a template)                                                                                                                                          | `[]`                                                    |
| `podAnnotations`                       | Additional annotations to apply to the pod.                                                                                                                                                                     | `{}`                                                    |
| `podLabels`                            | Additional labels to be added to pods                                                                                                                                                                           | `{}`                                                    |
| `podSecurityContext.fsGroup`           | Group ID for the container                                                                                                                                                                                      | `1001`                                                  |
| `podSecurityContext.runAsUser`         | User ID for the container                                                                                                                                                                                       | `1001`                                                  |
| `priorityClassName`                    | priorityClassName                                                                                                                                                                                               | `""`                                                    |
| `securityContext`                      | Security context for the container                                                                                                                                                                              | `{}`                                                    |
| `service.type`                         | Kubernetes Service type                                                                                                                                                                                         | `ClusterIP`                                             |
| `service.port`                         | QuMine-Server client port                                                                                                                                                                                       | `7979`                                                  |
| `service.nodePort`                     | Port to bind to for NodePort service type (client port)                                                                                                                                                         | `nil`                                                   |
| `service.clusterIP`                    | IP address to assign to service                                                                                                                                                                                 | `""`                                                    |
| `service.externalIPs`                  | Service external IP addresses                                                                                                                                                                                   | `[]`                                                    |
| `service.loadBalancerIP`               | IP address to assign to load balancer (if supported)                                                                                                                                                            | `""`                                                    |
| `service.loadBalancerSourceRanges`     | List of IP CIDRs allowed access to load balancer (if supported)                                                                                                                                                 | `[]`                                                    |
| `service.annotations`                  | Annotations to add to service                                                                                                                                                                                   | `{}`                                                    |
| `service.labels`                       | Labels to add to service                                                                                                                                                                                        | `{}`                                                    |
| `serviceAccount.create`                | Determine whether a Service Account should be created or it should reuse a exiting one.                                                                                                                         | `true`                                                  |
| `serviceAccount.name`                  | ServiceAccount to use. A name is generated using the qumine.fullname template if it is not set                                                                                                                  | `nil`                                                   |
| `serviceAccount.annotations`           | Additional Service Account annotations                                                                                                                                                                          | `{}`                                                    |
| `resources`                            | CPU/Memory resource requests/limits.                                                                                                                                                                            | `{}`                                                    |
| `livenessProbe`                        | Deployment Liveness Probe                                                                                                                                                                                       | See `values.yaml`                                       |
| `readinessProbe`                       | Deployment Readiness Probe                                                                                                                                                                                      | See `values.yaml`                                       |
| `extraVolumes`                         | A list of volumes to be added to the pod                                                                                                                                                                        | `[]`                                                    |
| `extraVolumeMounts`                    | A list of volume mounts to be added to the pod                                                                                                                                                                  | `[]`                                                    |
| `integrations.metrics.enabled`                      | Enable prometheus to access qumine metrics endpoint                                                                                                                                                             | `false`                                                 |
| `integrations.metrics.podAnnotations`               | Annotations for enabling prometheus to access the metrics endpoint                                                                                                                                              |                                                         |
| `integrations.metrics.serviceMonitor.enabled`       | Create ServiceMonitor object                                                                                                                                                                                    | `false`                                                 |
| `integrations.metrics.serviceMonitor.selector`      | Additional labels for ServiceMonitor object                                                                                                                                                                     | `{}`                                                    |
| `integrations.metrics.serviceMonitor.interval`      | Interval at which metrics should be scraped                                                                                                                                                                     | `30s`                                                   |
| `integrations.metrics.serviceMonitor.scrapeTimeout` | Timeout after which the scrape is ended                                                                                                                                                                         | `30s`                                                   |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-server \
  --set provider=aws qumine/minecraft-server
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-server -f values.yaml qumine/minecraft-server
```