repo-sync:
	git submodule init && git submodule update
	ln -sf kubevirt/cluster && ln -sf kubevirt/hack

.ONESHELL:
cluster-up: repo-sync
	source ./tools/env.sh && ./cluster/up.sh
	./tools/csi_up.sh

cluster-down:
	source ./tools/env.sh && ./cluster/down.sh

clean: cluster-down
	rm -rf cluster hack

.PHONY: repo-sync cluster-up cluster-down clean
