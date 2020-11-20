#!/bin/bash

# file_info: simple file information program

PROGRAM=$(basename $0) # 提取程序名

if [[ -e $1 ]]; then # 如果有参数
	echo -e "\nFile Type:"
	file $1
	echo -e "\nFile Status:"
	stat $1
else
	echo "$PROGRAM: usage: $PROGRAM file" >&2
	exit 1
fi
