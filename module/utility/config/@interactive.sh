# shellcheck shell=sh
# Configure `ls` if `lsd` is not installed
if test -z  "$(command -v "lsd")"; then
    alias ls='ls --color=auto'
    alias l='ls -l'
    alias la='ls -a'
    alias ll='ls -lah'
fi

# Configure `grep`
alias grep='grep --color=auto'

# Find
find_broken_links() {
    find "$1" -xtype l
}
