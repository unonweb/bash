#!/bin/bash

b_="\e[1m"
i_="\e[2m"
u_="\e[4m"
red_="\e[31m"
green_="\e[32m"
cyan_="\e[36m"
violett_="\e[35m"

_reset="\e[0m"


mapfile dirs < <(find . -maxdepth 1 -type d)
length=${#dirs[@]}

for (( i = 0; i < length; i++ )); do
    count=$(find ${dirs[$i]} -type f | wc -l)
    echo -e "${b_}${dirs[$i]}${_reset} \t\tcontains ${cyan_}${count}${_reset} files"
done	