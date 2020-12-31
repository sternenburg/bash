#!/bin/bash

# show123.sh: This script only accepts the following parameter: one, two or three.

echo "This program will print your selection!"
# read -p "Please input your choice: " choice
# case ${choice} in
case ${1} in
	"one")
		echo "Your choice is ONE"
		;;
	"two")
		echo "Your choice is two"
		;;
	"three")
		echo "Your choice is three"
		;;
	*)
		echo "Usage ${0} {one|two|three}"
		;;
esac

