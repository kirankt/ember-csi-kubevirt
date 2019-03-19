# Ember-CSI-Kubevirt

Ember-CSI-Kubevirt enables users to quickly fire up Ember-CSI on Kubernetes 1.11+ or OpenShift 3.11+.

Note: This repo is still work in progress.

## Usage
### All-in-one Demo Deployment

This deployment deploys an ephemeral Ceph container alongside Ember CSI and its sidecar containers.

```
$ git clone https://github.com/embercsi/ember-csi-kubevirt.git
$ cd ember-csi-kubevirt/
$ make all
```

At this point we have  fully working cluster with KubeVirt and Ember-CSI deployed. We can now deploy VMs.

```
# Creating a virtual machine
$ kubectl apply -f https://raw.githubusercontent.com/kubevirt/demo/master/manifests/vm.yaml

# After deployment you can manage VMs using the usual verbs:
$ kubectl get vms
$ kubectl get vms -o yaml testvm

# To start a VM you can use
$ ./virtctl start testvm

# Afterwards you can inspect the instances
$ kubectl get vmis
$ kubectl get vmis -o yaml testvm

# To shut it down again
$ ./virtctl stop testvm

# To delete
$ kubectl delete vms testvm
```

### Tear down the whole all-in-one deployment using:
```
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
