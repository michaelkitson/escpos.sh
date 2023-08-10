function _common_setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    escpos_printer() {
      cat
    }
}

dump_output() {
  printf "%s" "$output" | hexdump -C
}