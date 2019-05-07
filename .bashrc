export PS1="\e[0;31m\u \W > \[$(tput sgr0)\] \e[m"

. ~/dotfiles/bash-default.sh
. ~/dotfiles/bash-envars.sh
. ~/dotfiles/bash-shortcuts.sh
. ~/dotfiles/bash-git-prompt/gitprompt.sh
. ~/dotfiles/git-completion.bash

function wc3 {
	wine /home/matt/.wine/drive_c/Program\ Files\ \(x86\)/Warcraft\ III/Warcraft\ III.exe
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
