# QuMine / Charts

[![](https://github.com/qumine/charts/workflows/Release%20Charts/badge.svg?branch=master)](https://github.com/qumine/charts/actions)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=qumine_minecraft-server&metric=alert_status)](https://sonarcloud.io/dashboard?id=qumine_charts)

Docker Minecraft Server image with support for Plugins etc.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add qumine https://qumine.github.io/charts/
```

You can then run `helm search repo qumine` to see the charts.

## Charts

* [ingress-controller](https://github.com/qumine/charts/tree/master/charts/ingress-controller)
* [minecraft-server](https://github.com/qumine/charts/tree/master/charts/minecraft-server)

```bash
helm install --name your-release qumine/qumine-server
```

Also see [Artifact Hub](https://artifacthub.io/packages/search?org=qumine&sort=relevance&page=1) for a complete list.