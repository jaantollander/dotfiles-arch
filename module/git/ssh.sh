#!/bin/bash
COMMENT="$1"
ALGORITHM="ed25519"
SUFFIX="git"
IDFILE="$HOME/.ssh/id_${ALGORITHM}_${SUFFIX}"

if [ ! -f "$IDFILE" ]; then
    ssh-keygen -t "$ALGORITHM" -f "$IDFILE" -C "$COMMENT"
    echo "You should copy the public key ${IDFILE}.pub to GitHub https://github.com/settings/keys"
fi
