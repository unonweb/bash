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

# --- PACKAGES ---

if [[ ! -f /etc/apt/preferences.d/nosnap.pref ]]; then
  sudo rm /etc/apt/preferences.d/nosnap.pref
fi

apt update

sudo apt purge celluloid

# install packages

sudo apt install -y ssh vim keepassxc thunderbird git apache2

# Apache

if [[ ! -f /usr/sbin/a2enmod ]]; then
  sudo a2enmod ssl
fi
 
sudo systemctl enable --now apache2.service

# PPA: Node

curl -fsSL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt install -y nodejs

# npm

if [[ ! -d ~/npm-global ]]; then
  mkdir ~/npm-global && echo "~/npm-global created"
fi

npm config set prefix=/home/frida/npm-global

# npm packages

npm install -g npm@latest
npm install -g @11ty/eleventy


