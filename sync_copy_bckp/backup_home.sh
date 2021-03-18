#!/bin/bash

# import
if [[ -f /home/frida/.bash_variables ]]; then
	. /home/frida/.bash_variables
else
	echo "file /home/frida/.bash_variables not found"
fi

# Trash leeren
echo -e "\n** ${b_}removing trash ${_reset}**"
rm -rfv /home/frida/.local/share/Trash/files/*
rm -rfv /home/frida/.local/share/Trash/info/*
sleep 2

# Thumbnails löschen
echo -e "\n** ${b_}removing thumbnails ${_reset}**"
rm -rfv /home/frida/.cache/thumbnails/normal/*
sleep 2

# rsync
echo -e "\n** ${b_}performing rsync ${_reset}**"
sudo rsync --archive --recursive --human-readable --delete --progress --backup --backup-dir=/media/frida/Linux_Home_Backu/rsync_home_backup /home/frida /media/frida/Linux_Home_Backu/rsync_home
input=
while [[ $input != "q" ]]; do
	echo -e "\n** ${b_}hit q to abort${_reset}**"
	read -n 1 -p ">>" input
done
