echo "Removing old dotfiles"
rm -f ~/.gitconfig
rm -f ~/.bashrc

echo "Create symlinks to dotfiles"
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.bashrc ~/.bashrc

if [[ ! -z "$(which terminator)" ]]
then
  if [ -e ~/.config/terminator/config ]
  then
    echo "Adding terminator config."
    mkdir -p ~/.config/terminator
    rm -f ~/.config/terminator/config
    ln -s ~/dotfiles/terminator-config ~/.config/terminator/config
  fi
fi
