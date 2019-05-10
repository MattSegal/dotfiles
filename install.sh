# Add Sublime Text's GPG key to apt
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# Add Sublime Text's apt repo
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

apt update
apt install \
    curl \
    terminator \
    meld \
    sublime-text \
    chromium-browser \
    kolourpaint4 \
    awscli

# ALSO Install docker compose and docker
# ALSO Install yarn and nodeJS
# ALSO Install Gnome

if [ ! -d ./bash-git-prompt ]; then
  git clone https://github.com/magicmonty/bash-git-prompt.git bash-git-prompt --depth=1
fi
