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
# Source the environment and create a PVC
$ source tools/env.sh
$ k create -f examples/cirros-pvc.yml
$ k get pvc

# Wait for the CDI Importer pod to finish importing.
# Once done, the pod (job) vanishes at which point,
# we may proceed to create the VM.
$ k logs importer-cirros-pvc-v7fcs

# Create the VM
$ k create -f examples/cirros-vm.yml

# To inspect the VM use the alias to virtctl command.
$ v console cirros-vm

# To shut it down again
$ v stop cirros-vm

# To delete
$ k delete vms cirros-vm
```

### Tear down the whole all-in-one deployment using:
```
$ make cluster-down
```

### Deployment on an existing OCP or k8s cluster

The templates in the src directory can be applied directly on an existing K8s or OCP cluster.

```
kubectl create namespace ember-csi
kubectl -n ember-csi create -f src/install-operator.yml
```

On an OpenShift cluster you'll also need:

```
kubectl -n ember-csi create -f src/install-operator-scc.yml
```
