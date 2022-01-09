#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/redshift"
ln -sf "$DOTFILES/redshift/redshift.conf" "$XDG_CONFIG_HOME/redshift/redshift.conf"
