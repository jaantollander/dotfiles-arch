#!/usr/bin/env sh
mkdir -p "$HOME/.ssh"
chmod u=rwx,g=,o= "$HOME/.ssh"

mkdir -p "$HOME/.ssh/config.d"
chmod u=rwx,g=,o= "$HOME/.ssh/config.d"

ln -sf "$DOTMODULE/openssh/config/config" "$HOME/.ssh/config"

mkdir -p "$XDG_CONFIG_HOME/posix/login"
ln -sf "$DOTMODULE/openssh/config/@login.sh" "$XDG_CONFIG_HOME/posix/login/ssh.sh"
