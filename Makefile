repo-sync:
	git submodule init && git submodule update
	ln -sf kubevirt/cluster && ln -sf kubevirt/hack

.ONESHELL:
cluster-up: repo-sync
	cd kubevirt && ./cluster/up.sh && cd ..
	src/csi_up.sh

cluster-down:
	cd kubevirt && ./cluster/down.sh && cd ..

clean: cluster-down
	rm -rf cluster hack

.PHONY: repo-sync cluster-up cluster-down cluster-clean cluster-deploy cluster-sync clean
