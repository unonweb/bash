# --- DIRECTORY STRUCTURE ---

# Home

mv Templates/ templates
mv Downloads/ downloads
mv Pictures/ pictures
mv Videos/ video
rm -d Music/
rm -d Public/

if [[ ! -d /var/www ]]; then
  sudo mkdir /var/www && echo "/var/www created"
  sudo chown $USER /var/www
fi

# --- PACKAGES --- #

# PREPARATIONS
# ----------------------------------------------------------

# enable [snap] 

if [[ ! -f /etc/apt/preferences.d/nosnap.pref ]]; then
  sudo rm /etc/apt/preferences.d/nosnap.pref
fi

# add PPAS

# [Node]
curl -fsSL https://deb.nodesource.com/setup_15.x | sudo -E bash -

# remove some pre-installled software
sudo apt purge celluloid


# INSTALL
# -------------------------------------------------------------

# packages
apt update && sudo apt install -y ssh vim keepassxc thunderbird git apache2 snapd nodejs

# snaps
sudo snap install code


# CONFIG
# ----------------------------------------------------------

# [apache]

if [[ ! -f /usr/sbin/a2enmod ]]; then
  sudo a2enmod ssl
fi

# create a self-signed certificate
sudo openssl req -x509 -sha256 -newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt -days 1024 -nodes
sudo systemctl enable --now apache2.service

# [git] config

git config --global user.name "Udo Nonner"
git config --global user.email "udo.nonner@posteo.de"
git config --global core.editor "code --wait"
git config --global core.autocrlf input
git config --global diff.tool vscode
# review using git config --global -e
git config --global difftool.vscode.cmd "code --wait --diff $LOCAL $REMOTE"
# enable caching of the credentials
git config --global credential.helper cache


# NPM
# -------------------------------------------------------------

# config

if [[ ! -d ~/npm-global ]]; then
  mkdir ~/npm-global && echo "~/npm-global created"
fi

npm config set prefix=/home/frida/npm-global

# install npm packages

npm install -g npm@latest
npm install -g @11ty/eleventy