#!/bin/bash

# yes_to_stop_2.sh: Program uses "until" loop to repeat questions until user inputs the correct answer

until [ "${yn}" == "yes" -o "${yn}" == "YES" ]
do
	read -p "Please input yes/YES to stop this program: " yn
done

echo "OK! You input the correct answer!"

