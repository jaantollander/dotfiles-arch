#!/bin/bash
mkdir -p "$XDG_CONFIG_HOME/redshift"
ln -sf "$DOTFILES/redshift/config/redshift.conf" "$XDG_CONFIG_HOME/redshift/redshift.conf"
ln -sf "$DOTFILES/redshift/config/i3.conf" "$XDG_CONFIG_HOME/redshift/i3.conf"
