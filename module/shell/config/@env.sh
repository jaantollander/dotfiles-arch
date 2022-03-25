# Source other environment variables
ENVIRONMENT=$HOME/.config/shell/env
if [[ -d $ENVIRONMENT && -n `ls $ENVIRONMENT` ]]; then
    for x in $ENVIRONMENT/*; do
        source $x
    done
fi

# Set the default editor
export EDITOR="nvim"
export VISUAL="nvim"
