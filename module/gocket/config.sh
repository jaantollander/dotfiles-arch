#!/bin/bash
mkdir -p $XDG_CONFIG_HOME/gocket
if [[ -f $XDG_CONFIG_HOME/gocket/config.yml ]]; then
    echo "key: \"<token>\"" > $XDG_CONFIG_HOME/gocket/config.yml
fi
