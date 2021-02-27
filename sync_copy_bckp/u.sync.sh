#!/bin/bash

### --- TO DO

# list all directories with many many files inside
# list very very big files

### --- USAGE

# u.sync localPath to|from frida|karl|lem destination

### --- FUNCTIONS

closing () {
	input=""
	while [[ $input != "q" ]]; do
		echo -e "\n${cyan_}Hit q to abort${_reset}"
		read -n 1 -p ">> " input
		echo ""
		if [[ $input == "q" ]]; then exit; fi
	done
}


### --- VARIABLES ---

# get variables from external files
if [[ -f ~/.bash_variables ]]; then
	. ~/.bash_variables
else
	b_="\e[1m"
	i_="\e[2m"
	u_="\e[4m"
	red_="\e[31m"
	green_="\e[32m"
	cyan_="\e[36m"
	violett_="\e[35m"
	_reset="\e[0m"
fi

# set variables

rsyncCmd="rsync --archive --human-readable --delete --progress --exclude-from=/home/frida/code/bash/sync_copy_bckp/excludes -e"
# more options to ssh are given at the bottom in the execution string!
defRemotePath="~/incoming"
sshKey="/home/frida/.ssh/id_rsa"
localUser=$USER


### --- ARGUMENTS ---

# 1. arg: localPath

if [[ -e $1 ]]; then
	localPath=$1
	#echo "localPath set to ${localPath}."
else
	echo -e "{red_}error{_reset}: $1 is not a valid local path."
fi

# 2. arg: direction

if [[ $2 != "to" && $2 != "from" ]]; then
	echo -e "{red_}error{_reset}: $2 is not a valid direction."
	closing
fi

# 3. arg: set user:host

case $3 in
	"karl")
	userHost="frida@karl"
	;;
	"frida")
	userHost="frida@frida"
	;;
	"lem")
	userHost="frida@lem"
	;;
	*)
	echo -e "{red_}error{_reset}: $3 is not a valid destination host."
	closing
	;;
esac

# 4. arg (optional): remote path

if [[ ! -z $4 ]]; then
	remotePath=$4
else
	sameAsLocal=$(realpath $localPath)
	echo ""
	echo -e "${u_}Same${_reset} remote path: ${green_}${userHost}:${cyan_}${sameAsLocal}${_reset} ? (y|n)"
	read -n 1 -p ">> " input
	echo ""
	if [[ $input = "y" ]]; then
		remotePath=$sameAsLocal
	else
		echo -e "${u_}Default${_reset} remote path: ${green_}${userHost}:${cyan_}${defRemotePath}${_reset} ? (y|n)"
		read -n 1 -p ">> " input
		echo ""
		if [[ $input = "y" ]]; then
			remotePath=$defRemotePath
		fi
	fi
fi

if [[ -z $remotePath ]]; then
	echo -e "${red_}error${_reset}: destination required!"
	closing
fi

### --- BUILD CMD ---

case $2 in
	"to")
	#cmd="${rsyncCmd} 'sudo -u ${localUser} ssh -i ${sshKey}' ${localPath} ${userHost}:${remotePath}"
	cmd="${rsyncCmd} 'env SSH_AUTH_SOCK=$SSH_AUTH_SOCK ssh -i ${sshKey}' ${localPath} ${userHost}:${remotePath}"
	;;
	"from")
	#cmd="${rsyncCmd} 'sudo -u ${localUser} ssh -i ${sshKey}' ${userHost}:${localPath} ${remotePath}"
	cmd="${rsyncCmd} 'env SSH_AUTH_SOCK=$SSH_AUTH_SOCK ssh -i ${sshKey}' ${userHost}:${localPath} ${remotePath}"
	;;
esac


### --- INFO ---

echo -e "\n${u_}Command to be executed:${_reset}\n"
echo -e "$cmd"

#echo "Alright? (y|n)"
#read -n 1 -p ">> " input
#echo ""
#if [[ $input != "y" ]]; then
#	exit && echo "aborted by user"
#fi


### --- EXECUTE CMD ---

#ssh-add ${sshKey}
echo -e "\n** ${b_}performing rsync${_reset}**\n"

eval "$cmd"

if [[ $? != 0 ]]; then
	echo -e "\nsomething went wrong..."
	echo -e "Maybe create remote path? (y|n)"
	read -n 1 -p ">> " input
	if [[ $input == "y" ]]; then
		ssh ${userHost} mkdir -p ${remotePath}	
	fi
fi

closing