#! /bin/bash

# Pipe stdout from this example into your printer

set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../escpos.sh"

escpos_reset
escpos_qr_data "https://github.com/michaelkitson/escpos.sh"
echo "Default:"
escpos_qr_print
echo "Model 1:"
escpos_qr_model -1
escpos_qr_print
echo "Model 2:"
escpos_qr_model -2
escpos_qr_print
escpos_qr_model
echo "High error correction:"
escpos_qr_error_correction --high
escpos_qr_print
escpos_qr_error_correction
echo "Large:"
escpos_qr_size 6
escpos_qr_print
escpos_cut 3
