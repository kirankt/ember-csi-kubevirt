#!/usr/bin/env bash

KUBEVIRT_NUM_NODES=${KUBEVIRT_NUM_NODES:-1}

_kubectl='cluster/kubectl.sh'

# Deploy Ember CSI operator
$_kubectl create -f src/install-operator.yml

if [[ $KUBEVIRT_PROVIDER =~ .*os.* ]]; then
  $_kubectl create -f src/install-operator-scc.yml
fi

echo "Wait until the deployment is ready..."
$_kubectl -n ember-csi wait --timeout=300s --for=condition=Available deployment/ember-csi-operator
