### INTERACTION

#### Trash leeren?
echo -e "\n${cyan_}Remove local trash?${_reset} (y|n)"
read -n 1 -p ">> " trash

if [[ "$trash" = "y" ]]; then
	echo -e "\n** ${b_}removing trash ${_reset}**\n"
	rm -rfv ${home}.local/share/Trash/files/*
	rm -rfv ${home}.local/share/Trash/info/*
	sleep 2
else
	echo -e "\nOk, keep trash."
fi

### Thumbnails löschen?
echo -e "\n${cyan_}Empty ${home}.cache/thumbnails/normal/?${_reset} (y|n)"
read -n 1 -p ">> " thumbnails

if [[ "$thumbnails" = "y" ]]; then
	echo -e "\n** ${b_}removing thumbnails ${_reset}**\n"
	rm -fv ~/.cache/thumbnails/normal/*
	rm -fv ~/.cache/thumbnails/fail/gnome-thumbnail-factory/*
	rm -fv ~/.cache/thumbnails/fail/mate-thumbnail-factory/*
	sleep 2
else
	echo -e "\nOk, keep thumbnails."
fi

### Firefox Cache leeren?
echo -e "\n${cyan_}Empty ${home}.cache/mozilla/firefox/${firefoxProfile}/cache2/entries?${_reset} (y|n)"
read -n 1 -p ">> " firefox

if [[ "$firefox" = "y" ]]; then
	echo -e "\n** ${b_}removing cache entries ${_reset}**\n"
	rm -fv ~/.cache/mozilla/firefox/${firefoxProfile}/cache2/entries/*
	sleep 2
else
	echo -e "\nOk, keep cache."
fi