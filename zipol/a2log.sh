#! /bin/bash

## Version: 5

## VARIABLES ##

declare -a fields

norm="$(printf '\033[0m')"
bold="$(printf '\033[0;1m')"
red="$(printf '\033[0;31m')"
violet="$(printf '\033[0;35m')"

boldred="$(printf '\033[0;1;31m')"


## PARSE ARGS ##

while [[ $# > 0 ]]; do
        case "$1" in

                # cut fields
                ip) fields+=("1"); shift;;
                time) fields+=("4"); shift;;
                first) fields+=("5"); shift;;
                status) fields+=("6"); shift;;
                uri) 'cut -d\" -f2 | cut -d\  -f2 | sed "s/^-$/**NONE**/"'; shift;;
                user-agent) fields+=("9"); shift;;
                content-type) fields+=("10"); shift;;
                remote-port) fields+=("11"); shift;;
                v-host) fields+=("12"); shift;;
                ip-server) fields+=("13"); shift;;
                local-port) fields+=("14"); shift;;
                handler) fields+=("15"); shift;;
                tcp-status) fields+=("17"); shift;;
                id) fields+=("19"); shift;;
                ssl-proto) fields+=("20"); shift;;
                ssl-cipher) fields+=("21"); shift;;
                bytes-in) fields+=("22"); shift;;
                bytes-out) fields+=("23"); shift;;
                deflate-comp) fields+=("24"); shift;;
                duration) fields+=("25"); shift;;

                # printers
                tail) printer="tail $2"; shift; shift;;
                grep) printer="grep \"$2\""; shift; shift;;

                # other commands
                help) echo "available fields are: ip, time, first, status, user-agent, content-type, remote-port, v-host, ip-server, local-port, handler, tcp-status, id, ssl-proto, ssl-cipher, bytes-in, bytes-out, deflate-comp, duration, help"; exit 0;;
                # modifiers:
                sort) sort="| sort"; shift;;
                count) count="| sort | uniq -c"; shift;;

                # logath
                /*) logpath=$1; shift;;

                # catch rest
                *) echo "unknown command";;
        esac
done


## LOGPATH ##
# if not yet set after parsing the args, set a default:

logpath=${logpath:="/var/log/apache2/access.log"}

if [[ ! -r /var/log/apache2/access.log ]]; then
        echo "Can't find or access /var/log/apache2/access.log. Please specify log path as second argument"
fi


## PRINTER ##

# if a given logpath leads to a compressed file...
if [[ $logpath =~ .*\.gz ]]; then
        printer="zcat"
fi

# if not yet set after parsing args, set a default:
printer=${printer:=cat}



## CUT FIELDS ##

if [[ $fields ]]; then
        echo "fields selected: ${fields[@]}"
        for field in "${fields[@]}"; do
                str+=$field,
        done

        cut="| cut -d\| -f${str%,}"
fi


## TRIM ##

trim="| tr -s '| ' ' '"


## COLORIZE ##

# ip addresses
color="| sed -E \"s/([0-9]{1,3}\.){3}[0-9]{1,3}/${violet}&${norm}/g\""


## BUILT & EXECUTE ##

echo ""
# when inserting $str the trailing comma is removed
# cmd="$printer $logpath | cut -d\| -f${str%,} $trim $color"

cmd="$printer $logpath $cut $trim $color $count $sort"

eval "$cmd"


## ECHO ##

echo ""
echo "logpath: $logpath"
echo "command: $cmd"