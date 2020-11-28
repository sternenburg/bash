#!/bin/bash

# cal_average_random: Program calculates the average number created by RANDOM with the parameter user inputs.

read -p "Please input how many times you want to create an random integer: " ntimes

s=o
ave_num=0
for (( i=1; i<=${ntimes}; i=i+1 ))
do
	s=$(($s + ${RANDOM}*10/32767))
done

ave_num=$(($s/$ntimes))

echo "The average number created is ${ave_num} "

