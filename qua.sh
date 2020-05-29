#!/bin/bash


echo File "$1"
Q1pos=`cat $1 | awk 'END{u=0.75*(NR+1) ; print u}'`
echo Q1pos "$Q1pos"

if [[ "$Q1pos" =~ ^[0-9]+$ ]]; then
	echo $Q1pos | awk '{print $0 }'
	Q1=`cat $1 | awk -v Q1_a=$Q1pos 'NR==Q1_a{print $1}'`
else
	Q1_1=`echo $Q1pos | awk -F. '{print $1}' `
	Q1_2=`echo $Q1pos | awk -F. '{print ($1)+1}' `
	echo $Q1_1 $Q1_2 
	Q11=`cat $1 | awk -v Q1_a=$Q1_1 'NR==Q1_a{print $1}'`
	Q12=`cat $1 | awk -v Q1_b=$Q1_2 'NR==Q1_b{print $1}'`
	echo Q1 $Q12 $Q11
	Q1=`echo $(((Q12+Q11)/2))`
fi

echo $Q1

Q3pos=`cat $1 | awk 'END{u=0.25*(NR+1) ; print u}'`
echo Q3pos "$Q3pos"

if [[ "$Q3pos" =~ ^[0-9]+$ ]]; then
        echo $Q3pos | awk '{print $0 }'
        Q3=`cat $1 | awk -v Q3_a=$Q3pos 'NR==Q3_a{print $1}'`
else
        Q3_1=`echo $Q3pos | awk -F. '{print $1}' `
        Q3_2=`echo $Q3pos | awk -F. '{print ($1)+1}' `
        echo $Q3_1 $Q3_2
        Q31=`cat $1 | awk -v Q3_a=$Q3_1 'NR==Q3_a{print $1}'`
        Q32=`cat $1 | awk -v Q3_b=$Q3_2 'NR==Q3_b{print $1}'`
        echo Q3 $Q32 $Q31
        Q3=`echo $(((Q32+Q31)/2))`
fi

echo $Q3

echo
echo IQR ...
echo IQR = $Q3 - $Q1
IQR=`echo $((Q3-Q1))`
echo
echo "Q3 + ( 1.5 x IQR )"
UP_BOUND=`awk -v a=$Q3 -v b=$IQR 'BEGIN{print a+(b*1.5)}'`
echo $UP_BOUND

cat $1 | awk -v limit=$UP_BOUND '$1>limit{print $0}'

echo
#echo Upper ...
#cat $1 | awk -v uu=$UPPER '$1>uu{print $0}' | wc -l 

#lowerpos=`cat $1 | awk '{num=NR; c+=$1}END{l=0.25*(NR+1) ; print l}'`
#echo lowerpos "$lowerpos"





#upper=`awk -v upp=$upperpos -F. '{if ($upp~/^[0-9]+$/) print $upp; else print $1,$1+1}'    '{if (upp~/^[0-9]+$/) print $upp ; else print $1 }' $1`
#echo upper $upper
#lower=`awk -v low=$lowerpos -F"[\.\t]" '{if (low~/^[0-9]+$/) print $low ; else print $1 }' $1`
#echo lower $lower


#inter=${upper}-${lower}
#echo inter $inter

#sort -k1n lolo | awk '{num=NR; c+=$1}END{u=0.75*(NR+1); l=0.25*(NR+1);r=u-l print u,l; if (u~/^[0-9]+$/)print u " ok"; else print u " not ok"}'

