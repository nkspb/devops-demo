.PHONY: setup test test-integration test-all ci

IMAGE_NAME ?= devops-demo
IMAGE_TAG ?= local
DOCKERHUB_REPO ?= $(DOCKERHUB_USER)/devops-demo

setup:
	@echo "Creating a virtual environment..."
	python3 -m venv venv
	./venv/bin/python -m pip install -r requirements.txt

test: setup
	@echo "Running non-integration tests..."
	./venv/bin/python -m pytest -p no:cacheprovider -m "not integration"

test-integration:
	@echo "Running integration tests..."
	docker compose exec devops-demo python -m pytest -m integration

test-all:
	@echo "Running all tests..."
	docker compose exec devops-demo python -m pytest

ci:
	@echo "Running deployment pipeline"
	$(MAKE) test
	
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

	docker compose up -d --force-recreate --wait
	docker compose ps
	
	$(MAKE) test-integration
	echo "$$DOCKERHUB_TOKEN" | docker login -u "$$DOCKERHUB_USER" --password-stdin
	docker tag $(IMAGE_NAME):$(IMAGE_TAG) $(DOCKERHUB_REPO):$(IMAGE_TAG)
	docker push $(DOCKERHUB_REPO):$(IMAGE_TAG)
	docker logout
