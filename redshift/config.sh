#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/redshift"
ln -sf "$DOTFILES/redshift/config/redshift.conf" "$XDG_CONFIG_HOME/redshift/redshift.conf"
