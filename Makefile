test:
	@echo "Running non-integration tests..."
	python -m pytest -m "not integration"

test-integration:
	@echo "Running integration tests..."
	docker compose exec devops-demo python -m pytest -m integration

test-all:
	@echo "Running all tests..."
	docker compose exec devops-demo python -m pytest
