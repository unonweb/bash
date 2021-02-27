sudo rm /etc/apt/preferences.d/nosnap.pref
apt update

sudo apt remove celluloid
rm -rf /home/frida/.config/celluloid

sudo apt install -y ssh vim keepassxc thunderbird git apache2

# Node

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

if [[ ! -d /var/www ]]; then
  sudo mkdir /var/www && echo "/var/www created"
  sudo chown frida /var/www
fi

# Home directory structure

mv Templates/ templates
mv Downloads/ downloads
mv Pictures/ pictures
mv Videos/ video
rm -d Music/
rm -d Public/
