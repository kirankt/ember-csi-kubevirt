repo-sync:
	git submodule init && git submodule update
	ln -sf kubevirt/cluster && ln -sf kubevirt/hack

.ONESHELL:
cluster-up: repo-sync
	export KUBEVIRT_NUM_NODES=1 && export KUBEVIRT_PROVIDER=k8s-1.11.0 && ./cluster/up.sh
	./src/csi_up.sh

cluster-down:
	export KUBEVIRT_NUM_NODES=1 && export KUBEVIRT_PROVIDER=k8s-1.11.0 && ./cluster/down.sh

clean: cluster-down
	rm -rf cluster hack

.PHONY: repo-sync cluster-up cluster-down clean
