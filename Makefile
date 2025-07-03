FORESTER ?= opam exec -- forester

all: all-prod

all-prod: theme/forester.js
	$(FORESTER) build -vv

all-dev: theme/forester.js
	$(FORESTER) build --dev -vv

theme/forester.js: theme/javascript-source/forester.js
	cd theme && ./bundle-js.sh

cont: all-dev serve continuous
continuous:
	watchman-make -p 'trees/**/*' -t all-dev

serve: all-dev
	http-server -c-1 output &
exit:
	pkill http-server

clean: distclean
distclean:
	rm -rfv build output latex

.PHONY: all all-dev all-prod cont clean serve exit
