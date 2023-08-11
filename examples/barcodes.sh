#! /bin/bash

# Pipe stdout from this example into your printer

set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../escpos.sh"

escpos_reset
escpos_barcode --UPC-A 12345678901
escpos_cut 3
