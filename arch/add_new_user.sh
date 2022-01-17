#!/bin/bash
# Usage: bash add_new_user.sh <username>

user_name=$1

## --- Add a new user ---
useradd -m -g wheel -s /bin/bash "$user_name"

## --- Change the password for the user ---
passwd "$user_name$

# TODO: update sudoers?

