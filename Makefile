repo-sync:
	git submodule init && git submodule update
	ln -sf kubevirt/cluster && ln -sf kubevirt/hack

.ONESHELL:
cluster-up: repo-sync
	source ./tools/env.sh && ./cluster/up.sh

usecustomimages:
	source ./tools/env.sh && ./tools/usecustomimages.sh

deploy:
	source ./tools/env.sh && ./tools/deploy.sh

demo:
	source ./tools/env.sh && ./tools/demo.sh

all: cluster-up usecustomimages deploy demo

cluster-down:
	source ./tools/env.sh && ./cluster/down.sh

clean: cluster-down
	rm -rf cluster hack _out
	sed -i -e 's#registry:5000/##g' examples/external-ceph-cr.yml src/install-operator.yml

.PHONY: repo-sync cluster-up cluster-down clean usecustomimages deploy demo
