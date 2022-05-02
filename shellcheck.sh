#!/usr/bin/env sh
# Shellsheck all files with extensions ".sh" and ".bash".
ARGS="--exclude=SC1090,SC1091 --enable=deprecate-which --enable=avoid-nullary-conditions"
# shellcheck disable=SC2086
find . -name '*.sh' -type 'f' -print0 | xargs -0 shellcheck $ARGS
# shellcheck disable=SC2086
find . -name '*.bash' -type 'f' -print0 | xargs -0 shellcheck $ARGS
