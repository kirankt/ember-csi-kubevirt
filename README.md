# Ember-CSI-Kubevirt

Ember-CSI-Kubevirt enables users to quickly fire up Ember-CSI on Kubernetes 1.11+ or OpenShift 3.11+.

Note: This repo is still work in progress.

## Usage
### All-in-one Demo Deployment

This deployment deploys an ephemeral Ceph container alongside Ember CSI and its sidecar containers.

```
$ git clone https://github.com/embercsi/ember-csi-kubevirt.git
$ cd ember-csi-kubevirt/
$ make cluster-up
$ make deploy
$ make demo
$ make cluster-down
```

### Deployment on an existing OCP or k8s cluster

The templates in the src directory can be applied directly on an existing K8s or OCP cluster.

```
kubectl apply -f src/install-operator.yml
```

On an OpenShift cluster you'll also need:

```
kubectl apply -f src/install-operator-scc.yml
```
