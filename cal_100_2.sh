#!/bin/bash

#cal_1_100_2.sh: Calculate 1+2+..+100 by using for loop

read -p "Please input an interger: " nu

s=0
for (( i=1; i<=${nu}; i=i+1 ))
do
	s=$(($s+$i))
done
echo "The result of '1+2+3+...+${nu}' is ==> ${s}"

