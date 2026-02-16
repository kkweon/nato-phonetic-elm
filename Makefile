default: build


build:
	elm make src/Main.elm --output docs/js/main.js


dev:
	elm reactor


clean:
	rm -f docs/js/main.js


.PHONY: build dev clean
