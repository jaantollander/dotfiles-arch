#!/bin/bash

# Start ssh-agent if it is not started yet.
if [[ -z $(pgrep "ssh-agent") ]]; then
    eval `ssh-agent -s`
fi
