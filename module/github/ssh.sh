#!/bin/bash
# Usage:
# ssh.sh <github-username>
GITHUB_USERNAME=$1
ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519_github" -C "${GH_USERNAME}"
ssh-add "$HOME/.ssh/id_ed25519_github"
echo "You should copy the public key \$HOME/.ssh/id_ed25519_github.pub to GitHub https://github.com/settings/keys"
