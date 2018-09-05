#!/usr/bin/env bash

source hack/common.sh

_kubectl='cluster/kubectl.sh'
KUBEVIRT_NUM_NODES=${KUBEVIRT_NUM_NODES:-1}
KUBEVIRT_PROVIDER=${KUBEVIRT_PROVIDER:-k8s-1.11.0}

function _ssh() {
  cluster/cli.sh ssh node$(printf "%02d" $1) -- sudo $2
}

for i in $(seq 1 ${KUBEVIRT_NUM_NODES}); do
    # Setup iSCSI and multipath
    _ssh $i 'yum install -y iscsi-initiator-utils device-mapper-multipath ceph-common'
    _ssh $i 'mpathconf --enable --with_multipathd y --user_friendly_names n --find_multipaths y'
    _ssh $i 'systemctl enable --now iscsid'
    _ssh $i 'systemctl restart multipathd'

done

# Deploy Ember CSI
if [[ $KUBEVIRT_PROVIDER =~ .*k8s.* ]]; then
	$_kubectl apply -f src/ember-csi-k8s.yml
elif [[  $KUBEVIRT_PROVIDER =~ .*ocp.* ]]; then
	$_kubectl apply -f src/ember-csi-ocp.yml
fi
