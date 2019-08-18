all:
	rm -rf build
	elm make src/Main.elm --optimize
	mkdir build
	mv index.html build/index.html
	cp -rf assets/ build/assets/
