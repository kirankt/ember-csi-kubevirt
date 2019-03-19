repo-sync:
	git submodule init && git submodule update
	ln -sf kubevirt/cluster && ln -sf kubevirt/hack

.ONESHELL:
cluster-up: repo-sync
	source ./tools/env.sh && ./cluster/up.sh

deploy:
	source ./tools/env.sh && ./tools/deploy.sh

demo:
	source ./tools/env.sh && ./tools/demo.sh

all: cluster-up deploy demo

cluster-down:
	source ./tools/env.sh && ./cluster/down.sh

clean: cluster-down
	rm -rf cluster hack _out

.PHONY: repo-sync cluster-up cluster-down clean deploy demo
