#!/bin/bash

# show123_2.sh: Program uses function to repeat information

function printit(){
	echo -n "Your choice is " # 加上 -n 可以不断行，继续在同一行显示
	echo ${1} | tr 'a-z' 'A-Z' # 这里的${1}指的是printit函数的参数，不是主程序的参数！
}

echo "This program will print your selection!"
case ${1} in
	"one")
		printit ${1}
		;;
	"two")
		printit ${1}
		;;
	"three")
		printit ${1}
		;;
	*)
		echo "Usage ${0} {one|two|three}"
esac

