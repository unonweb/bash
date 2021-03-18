### DO NOT RENAME

closing() {
	input=""
	while [[ $input != "q" ]]; do
		echo -e "\n${cyan_}Hit q to abort${_reset}"
		read -n 1 -p ">> " input
		if [[ $input == "q" ]]; then exit; fi
	done
}
checkDir() {
# $1 = path
	if [[ ! -d $1 ]]; then
		echo -e "\n$1 doesn't exist!\n"
		return 1
	else
		return 0
	fi
}
checkFile() {
# $1 = path
	if [[ ! -e $1 ]]; then
		echo -e "\n$1 doesn't exist!\n"
		return 1
	else
		return 0
	fi
}