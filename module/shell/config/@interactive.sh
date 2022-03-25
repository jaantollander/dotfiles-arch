## Source other interactive scripts
INTERACTIVE=$XDG_CONFIG_HOME/shell/interactive
if [[ -d $INTERACTIVE && -n `ls $INTERACTIVE` ]]; then
    for x in $INTERACTIVE/*; do
        source $x
    done
fi
