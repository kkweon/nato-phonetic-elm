default: build


build:
	elm make src/Main.elm --output docs/js/main.js


dev:
	@echo "Starting dev server with auto-reload..."
	@if command -v elm-live >/dev/null 2>&1; then \
		elm-live src/Main.elm --dir=docs --start-page=index.html -- --output=docs/js/main.js; \
	else \
		echo "elm-live not found. Install with: npm install -g elm-live"; \
		echo "Falling back to basic dev server (no auto-reload)..."; \
		elm make src/Main.elm --output docs/js/main.js; \
		echo "Server running at http://localhost:8000"; \
		cd docs && python3 -m http.server 8000; \
	fi


clean:
	rm -f docs/js/main.js


build-prod:
	@echo "Updating sitemap.xml with current date..."
	@sed -i.bak "s|<lastmod>.*</lastmod>|<lastmod>$$(date -u +%Y-%m-%d)</lastmod>|g" docs/sitemap.xml && rm -f docs/sitemap.xml.bak
	@echo "Building optimized Elm application..."
	elm make src/Main.elm --output docs/js/main.js --optimize


.PHONY: build build-prod dev clean
