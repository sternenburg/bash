#!/bin/bash
# cal_pi.sh: User input a scale number to calculate pi number.

echo -e "This program will calculate pi value. \n"
echo -e "Please input a float number to calculate pi value. \n"
read -p "The scale number (10~10000)?" checking
num=${checking:-"10"}
echo -e "Starting calculate pi value. Be patient."
time echo "scale=${num}; 4*a(1)" | bc -lq
