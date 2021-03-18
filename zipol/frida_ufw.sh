#! /bin/bash

fridas_ip=$(cat /home/zipol/frida/fridas_ip)

# set new ufw rule:
ufw allow proto tcp from ${fridas_ip} to 82.165.122.48 port 19999
ufw allow proto tcp from ${fridas_ip} to 82.165.122.48 port 80,443

### OLD RULE? ###

# set IFS to newline; read output of grep (only matching) into array:
IFS=$'\n' mapfile -t ufw_ip_list < <( ufw status numbered | egrep -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" )

for element in "${ufw_ip_list[@]}"; do
	if [[ $element != "$fridas_ip" && $element != "82.165.122.48" ]]; then
		rule_line=$(ufw status numbered | grep "$element")
		echo "The following old rule has been found:"
		echo $rule_line
		read -n 1 -p "Delete? (y|n) >> " answer
		echo ""
		case $answer in
			"y")
				rule_nr=${rule_line%%]*}
				rule_nr=${rule_nr#[![:digit:]]}
				ufw delete ${rule_nr}
				;;
			"n") continue
				;;
		esac
	fi
done

unset ufw_ip_list

