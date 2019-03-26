#!/usr/bin/env bash

# The default provider Ember-CSI uses
export KUBEVIRT_NUM_NODES=1
export KUBEVIRT_PROVIDER=${KUBEVIRT_PROVIDER:-os-3.11.0}

# Kubevirt Version
export KUBEVIRT_VERSION=v0.15.0

# Useful aliases
alias k='./cluster/kubectl.sh -n sample-project'
alias v='./cluster/virtctl.sh -n sample-project'
