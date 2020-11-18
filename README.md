# QuMine / Charts

[![](https://github.com/qumine/charts/workflows/Release%20Charts/badge.svg?branch=master)](https://github.com/qumine/charts/actions)

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add qumine https://qumine.github.io/charts/
```

You can then run `helm search repo qumine` to see the charts.

## Charts

* [qumine-ingress](https://github.com/qumine/charts/tree/master/charts/qumine-ingress)
* [qumine-server](https://github.com/qumine/charts/tree/master/charts/qumine-server)

```bash
helm install --name your-release qumine/qumine-server
```

Also see [helm hub](https://hub.helm.sh/charts/qumine) for a complete list.