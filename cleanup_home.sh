### --- VARIABLES ---

firefoxProfile="1u32l0mb.default"

if [[ -f ${src}.bash_variables ]]; then
	. ${src}.bash_variables
else
	echo "file ${src}.bash_variables not found"
fi

while [[ $input != "q" ]]; do

	echo -e "\nThe following options are available:\n"

	echo -e "\t${b_}1)${_reset} ${cyan_}List residual config files${_reset}"
	echo -e "\t${b_}2)${_reset} ${cyan_}Remove residual config files${_reset}"
	echo -e "\t${b_}3)${_reset} ${cyan_}Remove thumbnails${_reset}"
	echo -e "\t${b_}4)${_reset} ${cyan_}Empty firefox cache${_reset}"
	echo -e "\t\t~/.cache/mozilla/firefox/${firefoxProfile}/cache2/entries"
	echo -e "\t${b_}5)${_reset} ${cyan_}Remove local trash${_reset}"
	echo -e "\t${b_}q)${_reset} ${cyan_}Quit${_reset}"

	read -n 1 -p ">> " input
	echo ""

	case $input in
		
		1) 
			dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2
			;;
		2)
			sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2)
			;;
		3)
			echo -e "\n** ${b_}removing thumbnails ${_reset}**\n"
			find ~/.thumbnails -type f -atime +7 -exec rm {} \;
			rm -fv ~/.cache/thumbnails/normal/*
			rm -fv ~/.cache/thumbnails/fail/gnome-thumbnail-factory/*
			rm -fv ~/.cache/thumbnails/fail/mate-thumbnail-factory/*
			;;
		4)
			echo -e "\n** ${b_}removing cache entries ${_reset}**\n"
			rm -fv ~/.cache/mozilla/firefox/${firefoxProfile}/cache2/entries/*
			;;
		5)
			echo -e "\n** ${b_}removing trash ${_reset}**\n"
			rm -rfv ~/.local/share/Trash/files/*
			rm -rfv ~/.local/share/Trash/info/*
			;;
		q)
			exit 1
			;;
		*)
			echo -e "\n${red_}illegal answer${_reset}"
			;;
	esac
done