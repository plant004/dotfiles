# change directory without cd ( only directory name )
setopt auto_cd
# memorize cd history
setopt auto_pushd
# correct suggestion when command not found
#setopt correct
# show packed list when ls
setopt list_packed
# no beep 
setopt nolistbeep
# set japanese
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    PROMPT="%/# "
    PROMPT2="%_# "
    SPROMPT="%r is correct? [n,y,a,e]: "
    # remote host name is white
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="${HOST%%.*} ${PROMPT}"
    ;;
# other is dark green
*)
    PROMPT="%/%% "
    PROMPT2="%_%% "
    SPROMPT="%r is correct? [n,y,a,e]: "
    # remote host name is white
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="${HOST%%.*} ${PROMPT}"
    ;;
esac

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt hist_ignore_dups # ignore duplication command history
setopt share_history # share command history data
PATH=$PATH:~/bin



# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt walters


# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

alias chpy='source ~/chpy.sh'

PYTHONHOME=/usr
export PYTHONHOME
PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.6:/usr/local/lib/python2.6/site-packages:/usr/local/lib/python2.6/site-packages/django
export PYTHONPATH
