>dprix.txt
>stonk.txt
nbsite=$(cat listesites|wc -l)
while [ "$nbsite" != 0 ]; do
	lien=$(cat listesites|head -n $nbsite|tail -n 1)
	wget -q -O oui "$lien" > oui
	((nbsite --))
	fin= 
	stonk=init
	uh=4
	while [ "$stonk" != "$fin" ]; do
		stonk=$(cat oui|grep -i line1=|awk -F '[],[]' '{print $'$uh'}')
		echo $stonk >> stonk.txt
		((uh=uh+5))
	done
	prixdolls=$(cat stonk.txt|tail -n 2|head -n 1)
	echo "$prixdolls $"
	prixeur=$(echo "scale=2; $prixdolls/1.2"|bc -l)
	echo "$prixeur €"

done
rm oui
