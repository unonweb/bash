#!/bin/bash

### TO DO

# list all directories with many many files inside
# list very very big files

### VARIABLES

user="frida"
src="/home/frida/"
dest="/media/backup-frida-on-karl"
nfs="karl:/home/frida/"
cmd="sudo rsync --archive --human-readable --delete --progress --exclude-from=/home/frida/code/bash/excludes"
firefoxProfile="1u32l0mb.default"

### FUNCTIONS

closing () {
	input=""
	while [[ $input != "q" ]]; do
		echo -e "\n${cyan_}Hit q to abort${_reset}"
		read -n 1 -p ">> " input
		if [[ $input == "q" ]]; then exit; fi
	done
}

### TESTS

if [[ -f ${src}.bash_variables ]]; then
	. ${src}.bash_variables
else
	echo "file ${src}.bash_variables not found"
fi

echo ""
echo -e "${u_}Mount NFS${_reset}\n"
sudo mount.nfs ${nfs} ${dest} && echo -e "Mounted ${nfs} at ${dest}"
if [[ $? != 0 ]]; then
	echo "Error while mounting"
	exit
fi

### INFO

echo -e "\n${u_}Command to be executed:${_reset}\n"
echo -e "\t${cyan_}${cmd} ${src} ${dest}${_reset}\n"
echo "Alright? (y|n)"
read -n 1 -p ">> " input
if [[ $input != "y" ]]; then
	exit && echo "aborted by user"
fi

### RSYNC

echo -e "\n** ${b_}performing rsync${_reset}**\n"

${cmd} ${src} ${dest}

closing

