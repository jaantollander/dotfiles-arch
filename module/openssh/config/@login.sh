# Start ssh-agent if it is not started yet.
if test -z $(pgrep "ssh-agent"); then
    eval $(ssh-agent -s)
fi
