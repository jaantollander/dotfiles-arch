#!/usr/bin/env sh
sudo mkdir -p "/etc/ssh"
sudo chmod u=rwx,g=rx,o=rx "/etc/ssh"
sudo cp "$DOTMODULE/openssh/etc/ssh_config" "/etc/ssh/ssh_config"
sudo chmod u=rw,g=r,o=r "/etc/ssh/ssh_config"
