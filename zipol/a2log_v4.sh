#! /bin/bash

declare -a fields

while [[ $# > 0 ]]; do
	case "$1" in
		ip) fields+=("1"); shift;;
		time) fields+=("4"); shift;;
		first) fields+=("5"); shift;;
		status) fields+=("6"); shift;;
		help) echo "available fields are: ip, time, first, status"
	esac
done

echo "fields selected: ${fields[@]}"

for field in "${fields[@]}"; do
	str+=$field,
done

# when inserting $str the trailing comma is removed
cat /var/log/apache2/access.log | cut -d\| -f${str%,}