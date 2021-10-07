# If not running interactively, don't do anything
[ -z "$PS1" ] && return
export PS1="\u \W > \[$(tput sgr0)\]"

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# Shortcuts
function stopdocker {
    docker update --restart=no `docker ps -q`
    docker kill `docker ps -q`
}
function cleandocker {
  # stop all containers:
  docker kill $(docker ps -q)

  # remove all containers
  docker rm $(docker ps -a -q)

  # remove all docker images
  docker rmi $(docker images -q)

  # remove all volumes
  docker volume rm $(docker volume ls -q)
}



. ~/dotfiles/bash-git-prompt/gitprompt.sh
. ~/dotfiles/git-completion.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Do Path stuff here
# export PATH=$PATH:/opt/flutter/bin
