#! /bin/bash

# This script is called by /home/zipol/.profile everytime a user logs in

# It receives as first argument a file containing an IP address
# It adds that given IP address to a general whitelist
# The ip address is only added if not yet present in the whitelist

path_whitelist="/home/zipol/whitelist"

if [[ -r $path_whitelist ]]; then
# check if the whitelist exists and if it's readable
	
	new_ip=$(<$1)
	mapfile whitelist <$path_whitelist
	regex_ip="[[:space:]]${new_ip}[[:space:]]"
	if [[ ! ${whitelist[@]} =~ ${regex_ip} ]]; then
		echo $new_ip >> $path_whitelist && echo -e "${CYAN}[$0]${RESET}: ip $new_ip successfully added"
		exit 0
	fi
	echo -e "${CYAN}[$0]${RESET}: ip $new_ip already on whitelist"
else
	echo -e "${CYAN}[$0]${RESET}: $path_whitelist no existent or not readable"
	exit 1
fi
