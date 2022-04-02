#!/bin/bash
mkdir -p $HOME/.ssh
chmod u=rwx,g=,o= $HOME/.ssh 

mkdir -p $HOME/.ssh/config.d
chmod u=rwx,g=,o= $HOME/.ssh/config.d 

ln -sf $DOTFILES/openssh/config/config $HOME/.ssh/config
chmod u=rw,g=,o= $HOME/.ssh/config

mkdir -p $XDG_CONFIG_HOME/shell/login
ln -sf $DOTFILES/openssh/config/@login.sh $XDG_CONFIG_HOME/shell/login/ssh.sh
