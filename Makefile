.PHONY: usage
usage:
	@echo "Use either \`make install\` to configure this machine or \`make test\` to run the test suite"
	@exit 1

.PHONY: install
install:
	./config-dev-machine.sh

.PHONY: test
test:
	for base in "ubuntu:18.04" "debian:buster" "ubuntu:19.10" ; do \
		docker build --rm --build-arg base=$$base -f test.Dockerfile . ; \
	done
