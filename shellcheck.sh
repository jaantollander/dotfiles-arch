#!/usr/bin/env sh
# Shellsheck all files with extensions ".sh" and ".bash".
find . -name '*.sh' -type 'f' -print0 | xargs -0 shellcheck
find . -name '*.bash' -type 'f' -print0 | xargs -0 shellcheck
