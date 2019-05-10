# If not running interactively, then don't do anything
# if [[ $- == *i* ]]; then
#     echo "Non-interactive shell"
#     return
# fi
export PS1="\u \W > \[$(tput sgr0)\]"

. ~/dotfiles/bash-default.sh
. ~/dotfiles/bash-envars.sh
. ~/dotfiles/bash-shortcuts.sh
. ~/dotfiles/bash-git-prompt/gitprompt.sh
. ~/dotfiles/git-completion.bash
