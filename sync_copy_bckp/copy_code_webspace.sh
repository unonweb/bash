#! /bin/bash

. /home/frida/code/bash/bash_functions.sh

css1="/home/frida/it/dev/web/eleventy/brain/code/style_morla_1.css"
css2="/home/frida/it/dev/web/eleventy/brain/code/style_morla_2.css"
js1="/home/frida/it/dev/web/eleventy/brain/code/script_morla.js"
dest="/var/www/morla/code/"

checkFile $css1
checkFile $css2
checkFile $js1

cp $css1 $dest && echo "copied"
cp $css2 $dest && echo "copied"
cp $js1 $dest && echo "copied"



