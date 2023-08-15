.PHONY: check clean test

SH_FILES = $(shell find src -name "*.sh" | sort)

escpos.sh: $(SH_FILES)
	echo "#!/usr/bin/env bash" > escpos.sh
	cat $(SH_FILES) | sed '/^#!/d' >> escpos.sh
	chmod +x escpos.sh

check: escpos.sh
	shellcheck escpos.sh

clean:
	rm escpos.sh

test:
	./test/bats/bin/bats test/2d_commands test
