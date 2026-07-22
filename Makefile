.PHONY: setup test test-integration test-all ci

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
	
	docker build -t devops-demo:0.1 .

	docker compose up -d --force-recreate --wait
	docker compose ps
	
	$(MAKE) test-integration
	echo "$$DOCKERHUB_TOKEN" | docker login -u "$$DOCKERHUB_USER" --password-stdin
	docker tag devops-demo:0.1 "$$DOCKERHUB_USER/devops-demo:0.1"
	docker push "$$DOCKERHUB_USER/devops-demo:0.1"
