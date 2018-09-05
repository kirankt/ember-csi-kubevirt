repo-sync:
	mkdir kubevirt && git submodule init && git submodule update
	ln -sf kubevirt/cluster && ln -sf kubevirt/hack

.ONESHELL:
cluster-up: repo-sync
	cd kubevirt && ./cluster/up.sh && cd ..
	src/csi_up.sh

cluster-down:
	cd kubevirt && ./cluster/down.sh && cd ..

cluster-build:
	cd kubevirt && ./cluster/build.sh && cd ..

cluster-clean:
	cd kubevirt && ./cluster/clean.sh && cd ..

cluster-deploy: cluster-clean
	cd kubevirt && ./cluster/deploy.sh && cd ..

cluster-sync: cluster-build cluster-deploy

clean: cluster-down
	rm -rf kubevirt cluster hack

.PHONY: repo-sync cluster-up cluster-down cluster-clean cluster-deploy cluster-sync clean
