>dprix.txt
>stonk.txt
nbsite=$(cat listesites|wc -l)
while [ "$nbsite" != 0 ]; do
	
	lien=$(cat listesites|head -n $nbsite|tail -n 1)
	wget -O oui "$lien" > oui
	((nbsite --))
	fin= 
	stonk=init
	uh=4
		while [ "$stonk" != "$fin" ]; do
		stonk=$(cat oui|grep -i line1=|awk -F '[],[]' '{print $'$uh'}')
		echo $stonk >> stonk.txt
		((uh=uh+5))
		done
	cat stonk.txt|tail -n 2|head -n 1 >> dprix.txt
done
rm oui
