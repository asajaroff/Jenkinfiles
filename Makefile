REGISTRY_OWNER := asajaroff
REGISTRY_NAME  := k8s-utils
IMAGE_TAG      := kops-1.17

.PHONY=build-k8s-utils push-k8s-utils

build-k8s-utils:
	docker build -t ${REGISTRY_OWNER}/${REGISTRY_NAME}:${IMAGE_TAG} \
		--load \
		- < Dockerfiles/kops_aws.Dockerfile

push-k8s-utils:
	docker build -t ${REGISTRY_OWNER}/${REGISTRY_NAME}:${IMAGE_TAG} \
		--push \
		- < Dockerfiles/kops_aws.Dockerfile

