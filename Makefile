repo-sync:
	git submodule init && git submodule update

.ONESHELL:
cluster-up:
	cd kubevirt && ./cluster/up.sh && cd ..

cluster-down:
	cd kubevirt && ./cluster/down.sh && cd ..

cluster-build:
	cd kubevirt && ./cluster/build.sh && cd ..

cluster-clean:
	cd kubevirt && ./cluster/clean.sh && cd ..

cluster-deploy: cluster-clean
	cd kubevirt && ./cluster/deploy.sh && cd ..

cluster-sync: cluster-build cluster-deploy

.PHONY: repo-sync cluster-up cluster-down cluster-clean cluster-deploy cluster-sync
