#!/bin/bash
COMMENT=$1
ALGORITHM="ed25519"
SUFFIX="aalto"
IDFILE="$HOME/.ssh/id_${ALGORITHM}_${SUFFIX}"

if [ ! -f "$IDFILE" ]; then
    ssh-keygen -t "$ALGORITHM" -f "$IDFILE" -C "$COMMENT"
    echo "run \`ssh-copy-id -i $IDFILE.pub <username>@kosh.aalto.fi\` to add the public key to aalto servers."
fi
