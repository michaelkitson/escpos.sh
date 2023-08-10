.PHONY: test

escpos.sh: src/*.sh
	echo "#!/usr/bin/env bash" > escpos.sh
	cat src/*.sh | sed '/^#!/d' >> escpos.sh

test: escpos.sh
	./test/bats/bin/bats test
