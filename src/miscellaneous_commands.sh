#!/usr/bin/env bash

escpos_reset() {
  printf "%s" "${ESCPOS_ESC}@"
}
