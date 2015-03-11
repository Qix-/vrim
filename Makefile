SRC:=\
	src/vrim.coffee \
	src/server.coffee \
	tty.coffee
JS=$(addprefix bin/,$(notdir $(SRC:.coffee=.js)))

all : bin-dir $(JS)

bin/%.js : src/%.coffee
	coffee -cp $< > $@

bin-dir :
	mkdir -p bin
