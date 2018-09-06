#!/usr/bin/env bash

# The default provider Ember-CSI uses
export KUBEVIRT_NUM_NODES=1
export KUBEVIRT_PROVIDER=k8s-1.11.0

# Useful aliases
alias k='./cluster/kubectl.sh -n ember-csi'
