#!/usr/bin/env bash

set -euo pipefail

KEY_DIR="/var/lib/sops/age"
KEY_FILE="$KEY_DIR/keys.txt"

if [[ ! -d $KEY_DIR ]]; then
  sudo mkdir -p $KEY_DIR
  sudo chown $USER $KEY_DIR
fi

if [[ -f $KEY_FILE ]]; then
  echo "Private key already exists at $KEY_FILE"
  echo "Deriving public key:"
  grep "^AGE-SECRET-KEY-" $KEY_FILE | age-keygen -y
else
  echo "Private key not found. Generating a new key pair."
  age-keygen -o $KEY_FILE
fi
