# Start ssh-agent if it is not started yet.
if test ! "$(pidof -x ssh-agent)"; then
    eval "$(ssh-agent -s)"
fi
