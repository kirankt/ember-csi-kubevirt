#!/bin/bash
set -xe

. tools/env.sh
_ssh='cluster/cli.sh ssh node01'

# Workaround for https://bugs.centos.org/view.php?id=14785
$_ssh "sudo touch /etc/rhsm/ca/redhat-uep.pem"

if [ -n "${EMBER_IMAGE_URL}" ]; then
	# Make sure domain name is resolved on node01
	HOSTNAME_ENTRY=`echo ${EMBER_IMAGE_URL} | awk -F[/:] '{print $4}' | xargs getent hosts`
	$_ssh "echo ${HOSTNAME_ENTRY} | sudo tee -a /etc/hosts"
	echo "Using custom image from ${EMBER_IMAGE_URL} for Ember-CSI"
	$_ssh "[[ -f /tmp/embercsi.tar.gz ]] || curl -o /tmp/embercsi.tar.gz \"${EMBER_IMAGE_URL}\""
	$_ssh 'sudo docker load -q -i /tmp/embercsi.tar.gz'
	$_ssh 'sudo docker tag $(sudo docker images -q */ember-csi-container) registry:5000/embercsi/ember-csi'
	$_ssh 'sudo docker push registry:5000/embercsi/ember-csi'
	sed -i -e 's#image: embercsi/ember-csi#image: registry:5000/embercsi/ember-csi#g' examples/external-ceph-cr.yml
fi

if [ -n "${EMBER_OPERATOR_IMAGE_URL}" ]; then
	# Make sure domain name is resolved on node01
	HOSTNAME_ENTRY=`echo ${EMBER_OPERATOR_IMAGE_URL} | awk -F[/:] '{print $4}' | xargs getent hosts`
	$_ssh "echo ${HOSTNAME_ENTRY} | sudo tee -a /etc/hosts"
	echo "Using custom image from ${EMBER_OPERATOR_IMAGE_URL} for Ember-CSI Operator"
	$_ssh "[[ -f /tmp/embercsioperator.tar.gz ]] || curl -o /tmp/embercsioperator.tar.gz \"${EMBER_OPERATOR_IMAGE_URL}\""
	$_ssh 'sudo docker load -i /tmp/embercsioperator.tar.gz'
	$_ssh 'sudo docker tag $(sudo docker images -q */ember-csi-operator-container) registry:5000/embercsi/ember-csi-operator'
	$_ssh 'sudo docker push registry:5000/embercsi/ember-csi-operator'
	sed -i -e 's#image: embercsi/ember-csi-operator#image: registry:5000/embercsi/ember-csi-operator#g' src/install-operator.yml
fi
