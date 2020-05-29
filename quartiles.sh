#!/usr/bin/bash


echo File "$1"
lowerpos=`cat $1 | awk '{num=NR; c+=$1}END{u=0.75*(NR+1) ; print u}'`
echo lowerpos "$lowerpos"

if [[ "$lowerpos" =~ ^[0-9]+$ ]]; then
	echo $lowerpos | awk '{print $0 }'
	LOWER=`cat $1 | awk -v LW=$lowerpos '{print $LW}'`
else
	low1=`echo $lowerpos | awk -F. '{print $1}' `
	low2=`echo $lowerpos | awk -F. '{print ($1)+1}' `
	echo $low1 $low2 
	LOW1=`cat $1 | awk -v LW1=$low1 'NR==LW1{print $1}'`
	LOW2=`cat $1 | awk -v LW2=$low2 'NR==LW2{print $1}'`
	echo $LOW2 $LOW1
	LOWER=`echo $(((LOW2+LOW1)/2))`
fi

echo $LOWER

upperpos=`cat $1 | awk '{num=NR; c+=$1}END{u=0.25*(NR+1) ; print u}'`
echo upperpos "$upperpos"

if [[ "$upperpos" =~ ^[0-9]+$ ]]; then
        echo $upperpos | awk '{print "Upp "$0 }'
        UPPER=`cat $1 | awk -v UP=$upperpos '{print $UP}'`
else
        upp1=`echo $upperpos | awk -F. '{print $1}' `
        upp2=`echo $upperpos | awk -F. '{print ($1)+1}' `
        echo $upp1 $upp2
        UPP1=`cat $1 | awk -v UP1=$upp1 'NR==UP1{print $1}'`
        UPP2=`cat $1 | awk -v UP2=$upp2 'NR==UP2{print $1}'`
        echo $UPP2 $UPP1
        UPPER=`echo $(((UPP2+UPP1)/2))`
fi

echo $UPPER

echo
echo Lower ...
cat $1 | awk -v ll=$LOWER '$1<ll{print $0}' | wc -l 
echo
echo Upper ...
cat $1 | awk -v uu=$UPPER '$1>uu{print $0}' | wc -l 

#lowerpos=`cat $1 | awk '{num=NR; c+=$1}END{l=0.25*(NR+1) ; print l}'`
#echo lowerpos "$lowerpos"





#upper=`awk -v upp=$upperpos -F. '{if ($upp~/^[0-9]+$/) print $upp; else print $1,$1+1}'    '{if (upp~/^[0-9]+$/) print $upp ; else print $1 }' $1`
#echo upper $upper
#lower=`awk -v low=$lowerpos -F"[\.\t]" '{if (low~/^[0-9]+$/) print $low ; else print $1 }' $1`
#echo lower $lower


#inter=${upper}-${lower}
#echo inter $inter

#sort -k1n lolo | awk '{num=NR; c+=$1}END{u=0.75*(NR+1); l=0.25*(NR+1);r=u-l print u,l; if (u~/^[0-9]+$/)print u " ok"; else print u " not ok"}'

