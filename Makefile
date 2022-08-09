IMAGE_REPOSITORY ?= docker.fylr.io/services/postfix

BUILD_ARGS?=-t ${IMAGE_REPOSITORY}:latest

container:
	@echo "Building container with tag: ${TAGNAME}"
	docker build \
		--no-cache \
		--platform linux/amd64 \
		--pull \
		--label="version=${TAG_FULL_VERSION}" \
		${BUILD_ARGS} \
		-f Dockerfile .

.PHONY: container
