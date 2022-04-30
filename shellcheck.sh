#!/usr/bin/env sh
find . -name '*.sh' -type 'f' -print0 \
    | xargs -0 shellcheck
