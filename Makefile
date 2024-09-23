FORESTER ?= opam exec -- forester

all: all-output

all-output: theme/forester.js
	$(FORESTER) build --dev
theme/forester.js: theme/javascript-source/forester.js
	cd theme && ./bundle-js.sh

cont: all serve continuous
continuous:
	watchman-make -p 'trees/**/*' -t all

serve: all-output
	http-server -c-1 output &
exit:
	pkill http-server

clean: distclean
distclean:
	rm -rfv build output latex

.PHONY: all cont clean serve exit
