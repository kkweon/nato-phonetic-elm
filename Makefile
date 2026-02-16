default: build


build:
	elm make src/Main.elm --output docs/js/main.js


dev:
	@echo "Building and starting dev server..."
	@elm make src/Main.elm --output docs/js/main.js
	@echo "Server running at http://localhost:8000"
	@cd docs && python3 -m http.server 8000


clean:
	rm -f docs/js/main.js


.PHONY: build dev clean
