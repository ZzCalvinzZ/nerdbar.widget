# Display spaces using in a bar that accepts stdout
kwmc=/usr/local/bin/kwmc


# get active and previous space
active=$($kwmc query space active id)
previous=$($kwmc query space previous id)

# get array of spaces
spaces=()
i=1
while read -r line
do
    spaces[i]="$line"
    (( i++ ))
done <<< "$($kwmc query space list)"

# populate bar with icons
bar=()
for (( i = 1; i < ${#spaces[@]} + 1; i++ ))
do
	if [[ ${spaces[$i]} == *"[no tag]" ]] #|| "$i" -lt 5 ]]
	then
		bar[$i]=$(($i))
	else
		if [[ "$i" == "9" ]]
		then
			id="${spaces[$i]:4}"
		else
			id="${spaces[$i]:3}"
		fi
		# bar[$i]="$(echo $id | tr '[:lower:]' '[:upper:]')"
		 bar[$i]="$(echo $id )"
	fi
done

# style active and previous space icons
bbar=()
for (( i = 1; i < ${#bar[@]} + 1; i++ ))
do
	if [[ $(($i)) == "$active" ]]
	then
		bbar[(($i*3))]="("${bar[$i]}")"
	else
		bbar[(($i*3))]=" (${bar[$i]} "
	fi
done

echo "$($kwmc query space active mode) @ ${bbar[*]}"
