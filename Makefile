default: build


build:
	mkdir -p dist
	cp -r public/css dist/
	cp -r public/vendors dist/
	cp public/index.html dist/
	mkdir -p dist/js
	npx elm make src/Main.elm --output dist/js/main.js


clean:
	rm -rf dist


.PHONY: build, clean
