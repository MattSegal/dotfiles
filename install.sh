apt update
apt upgrade

apt install curl

# Add Sublime Text's GPG key to apt
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# Add Docker's GPG key to apt
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Sublime Text's apt repo
echo "deb https://download.sublimetext.com/ apt/stable/" | 
  tee /etc/apt/sources.list.d/sublime-text.list

# Add Docker's apt repo
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Add Gnome's apt repo
add-apt-repository ppa:gnome3-team/gnome3

apt update

apt install terminator && \
apt install sublime-text && \
apt install docker.io && \
apt install chromium && \
apt install shutter && \
apt install gnome-shell ubuntu-gnome-desktop


# docker compose
COMPOSE_URL=https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m`
curl -L $COMPOSE_URL -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
