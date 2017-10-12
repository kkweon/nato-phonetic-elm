default: build


build:
	elm-make src/Main.elm --output docs/js/main.js


clean:
	rm -f docs/js/main.js


.PHONY: build, clean
