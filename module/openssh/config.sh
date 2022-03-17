#!/bin/bash
mkdir -p $HOME/.ssh
chmod u=rwx,g=,o= $HOME/.ssh 

# System-wide configuration
#sudo mkdir -p /etc/ssh
#sudo chmod u=rwx,g=rx,o=rx /etc/ssh
#sudo cp $DOTFILES/openssh/config/ssh_config /etc/ssh/ssh_config
#sudo chmod u=rw,g=r,o=r /etc/ssh/ssh_config

# User's configuration. Create if doesn't exist.
touch $HOME/.ssh/config
chmod u=rw,g=,o= $HOME/.ssh/config

#mkdir -p $XDG_CONFIG_HOME
#ln -sf $DOTFILES/openssh/config/start-ssh-agent.sh $XDG_CONFIG_HOME/start-ssh-agent.sh
