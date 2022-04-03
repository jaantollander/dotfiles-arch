fpath=($ZDOTDIR/external $fpath)


# History filepath
export HISTFILE="$ZDOTDIR/.zhistory"

# Maximum events for internal history
export HISTSIZE=10000

# Maximum events in history file
export SAVEHIST=10000


## Source common interactive scripts
source $XDG_CONFIG_HOME/shell/interactive.sh


## --- Filesystem Navigation ---
source "$XDG_CONFIG_HOME/zsh/external/bd.zsh"

# Push the current directory visited on to the stack.
setopt AUTO_PUSHD

# Do not store duplicate directories in the stack
setopt PUSHD_IGNORE_DUPS

# Do not print the directory stack after using
setopt PUSHD_SILENT

# list directories
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index


## --- Command Completion ---
source $XDG_CONFIG_HOME/zsh/external/completion.zsh
zmodload zsh/complist
autoload -Uz compinit; compinit
_comp_options+=(globdots) # With hidden files


## --- Prompt ---
autoload -Uz prompt_purification_setup; prompt_purification_setup


## --- VIM Key Bindings ---
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v
export KEYTIMEOUT=1
autoload -Uz cursor_mode && cursor_mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line


## --- Key Bindings ---
# Unbind clearing shell from CTRL+l
bindkey -r '^l'
# Bind clearing shell to CTRL+g
bindkey -r '^g'
bindkey -s '^g' 'clear\n'
# Open tmux
bindkey -r '^p'
bindkey -s '^p' 'tmux\n'


## --- Syntax Highlighting ---
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


## --- PATH ---
# Copied from "/etc/profile"
# Append "$1" to $PATH when not already in.
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

# Append local binaries to path
append_path $XDG_BIN_HOME
