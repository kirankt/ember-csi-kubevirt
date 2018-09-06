# Ember-CSI-Kubevirt

Ember-CSI-Kubevirt enables users to quickly fire up Ember-CSI on Kubernetes 1.11+ or OpenShift 3.11+.

Note: This repo is still work in progress.

## Usage
### All-in-one Demo Deployment

This deployment deploys an ephemeral Ceph container alongside Ember CSI and its sidecar containers.

```
$ git clone https://github.com/kirankt/ember-csi-kubevirt.git
$ cd ember-csi-kubevirt/
$ make cluster-up
$ source tools/env.sh 
$ k apply -f examples/pvc.yml 
$ k get pvc
$ k apply -f examples/sleep.yml 
$ make cluster-down
```

### Deployment on an existing OCP or k8s cluster

The templates in the src directory can be applied directly on an existing K8s or OCP cluster.

```
kubectl apply -f src/ember-csi-k8s.yml
```

or in an OpenShift cluster using:

```
oc apply -f src/ember-csi-ocp.yml
```
