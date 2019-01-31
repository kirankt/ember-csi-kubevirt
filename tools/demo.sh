#!/usr/bin/env bash
_kubectl='cluster/kubectl.sh'

# Install a Ceph demo container
$_kubectl create -f examples/ceph-demo.yml

echo "Wait until the pod is ready..."
$_kubectl wait -n ceph-demo --timeout=300s --for=condition=Ready pod/ceph-demo-pod

# Create the required secret
[ -e etc ] && rm -rf etc
$_kubectl -n ceph-demo cp ceph-demo/ceph-demo-pod:/etc/ceph/ etc/ceph/
echo -e "\n[client]\nrbd default features = 3\n" >> etc/ceph/ceph.conf
tar cf system-files.tar etc/ceph/ceph.conf etc/ceph/ceph.client.admin.keyring
$_kubectl create -n ember-csi secret generic system-files --from-file=system-files.tar
[ -e system-files.tar ] && rm system-files.tar
[ -e etc ] && rm -rf etc

# Create a new storage class
$_kubectl create -f examples/external-ceph-cr.yml

echo "Wait until the pod is ready..."
$_kubectl -n ember-csi wait --timeout=300s --for=condition=Ready pod/external-ceph-controller-0

# Let's create a sample PVC and pod using the PVC
$_kubectl create namespace sample-project

$_kubectl -n sample-project create -f examples/pvc.yml
$_kubectl -n sample-project create -f examples/sleep.yml

$_kubectl -n sample-project wait --timeout=300s --for=condition=Ready pod/busybox-sleep
$_kubectl -n sample-project describe pods busybox-sleep | tail
$_kubectl -n sample-project exec -it busybox-sleep  -- df -h | grep -B 1 /data
