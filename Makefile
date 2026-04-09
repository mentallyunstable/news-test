builder: ## Runs build_runner build command
	@echo "╠ Running build_runner generator..."
	@fvm dart run build_runner build --delete-conflicting-outputs

analyze: ## Runs analyze command
	@echo "╠ Running code analysis..."
	@fvm dart analyze
