TARGETS = index.js test.js

all: $(TARGETS)

%.js: src/%.coffee
	coffee -cb -o . $<

clean:
	rm -f $(TARGETS)
