#!/usr/bin/env bash

if [ "$1" == "-v" ] || [ "$1"  == "--version" ]; then
  echo "escpos.sh $ESCPOS_VERSION"
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  _escpos_help
fi
