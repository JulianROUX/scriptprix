echo "calcul cours euro:"
wget -q -O cours "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml" > cours
eur=$(cat cours | grep -i USD |awk '{print $3 }' |awk -F '[=]' '{print $2 }'|cut -f2 -d "'")
echo "1€=$eur$"
>stonk.txt
nbsite=$(cat listesites|wc -l)
prixtt=0
while [ "$nbsite" != 0 ]; do
	lien=$(cat listesites|head -n $nbsite|tail -n 1)
	wget -q -O tmp "$lien" > tmp
	fin= 
	stonk=init
	uh=4
	while [ "$stonk" != "$fin" ]; do
		stonk=$(cat tmp|grep -i line1=|awk -F '[],[]' '{print $'$uh'}')
		echo $stonk >> stonk.txt
		((uh=uh+5))
	done
	prixdolls=$(cat stonk.txt|tail -n 2|head -n 1)
	skin=$(cat listesites|head -n $nbsite |tail -n 1|awk -F '[/]' '{print $7}' |sed "s/%20/ /g" |sed "s/%7C//g"| sed "s/%28/ /g" |sed "s/%29//g"|sed "s/  / /g")
	echo "Prix de $skin :"
	echo "$prixdolls $"
	prixeur=$(echo "scale=2; $prixdolls/$eur"|bc -l)
	echo "$prixeur €"
	prixtt=$(echo " $prixtt + $prixeur "|bc -l)
	echo "Le prix total est de $prixtt €"
	((nbsite--))
done
rm tmp
temps=$(date +"%d/%m/%Y %H:%M")
echo " $temps : $prixtt " >> prix.txt
rm cours
