moy=0 ; prix=0 ; testdiv=0
nbligne=$(cat prix.txt|wc -l)
# Moyenne total
echo "Moyenne des prix depuis le début:"
while [ "$nbligne" != 0 ]; do
prix=$(cat prix.txt | awk -F '[ ]' '{print $5 }' |tail -n $nbligne|head -n 1)
((testdiv++))
moy=$(echo " $moy + $prix "|bc -l)
moy2=$(echo "scale=2; $moy / $testdiv"|bc -l)
echo -ne "\r$moy2"
#echo $testdiv
((nbligne--))
done
echo
#moy 10 dernieres lignes
nbligne=10
# Moyenne total
echo "Moyenne des $nbligne derniers prix:"
while [ "$nbligne" != 0 ]; do
prix=$(cat prix.txt | awk -F '[ ]' '{print $5 }' |tail -n $nbligne|head -n 1)
((testdiv++))
moy=$(echo " $moy + $prix "|bc -l)
moy2=$(echo "scale=2; $moy / $testdiv"|bc -l)
echo -ne "\r$moy2"
#echo $testdiv
((nbligne--))
done
echo

#min
pmin=99999
nbligne=$(cat prix.txt|wc -l)
echo "Prix minimum:"
while [ "$nbligne" != 0 ]; do
prix=$(cat prix.txt | awk -F '[ ]' '{print $5 }' |tail -n $nbligne|head -n 1)
bool=$(echo "$prix < $pmin"|bc -l)
if [[ "$bool" == 1 ]]; then
pmin=$(echo "$prix"|bc -l)
fi
echo -ne "\r$pmin"
((nbligne--))
done
echo

#max
pmax=0;bool=0
nbligne=$(cat prix.txt|wc -l)
echo "Prix maximum:"
while [ "$nbligne" != 0 ]; do
prix=$(cat prix.txt | awk -F '[ ]' '{print $5 }' |tail -n $nbligne|head -n 1)
bool=$(echo "$prix > $pmax"|bc -l)
if [[ "$bool" == 1 ]]; then
pmax=$(echo "$prix"|bc -l)
fi
echo -ne "\r$pmax"
((nbligne--))
done
echo
