# Remove old stuff
rm -f ~/.gitconfig
rm -f ~/.bashrc

# Create symlinks
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.bashrc ~/.bashrc

if [ -e ~/.config/terminator/config ]
then
  rm ~/.config/terminator/config
  ln -s ~/dotfiles/terminator-config ~/.config/terminator/config
fi