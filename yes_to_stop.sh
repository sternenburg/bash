#!/bin/bash

# yes_to_stop.sh: Program repeats questions until user inputs correct answer.

while [ "${yn}" != "yes" ] && [ "${yn}" != "YES" ]
# while [ "${yn}" != "yes" -a "${yn}" != "YES" ]
do
	read -p "Please input yes/YES to stop the program: " yn
done
echo "OK! You input the correct unswer!"



