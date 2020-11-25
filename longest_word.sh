#!/bin/bash

# longest_word: find longest string in a file

while [[ -n $1 ]]; do	# 如果字符串长度大于0，也就是说用户输入了文件名
	if [[ -r $1 ]]; then # 如果文件存在且可读
		max_word=
		max_len=0
		for i in $(strings $1); do
			len=$(echo $i | wc -c)
			if (( len > max_len )); then
				max_len=$len
				max_word=$i
			fi
		done
		echo "$1: '$max_word' ($max_len characters)"
	fi
	shift
done
