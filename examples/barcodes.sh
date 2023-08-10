#! /bin/bash

set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../escpos.sh"

(
  escpos_reset
  escpos_barcode --UPC-A 12345678901
  escpos_cut 3
) |
nc 192.168.1.10 9100
