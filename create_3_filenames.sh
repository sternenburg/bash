#!/bin/bash
# create_3_filenames.sh: Program to create 3 files, which named by user's input and date command.
PATH=/home/lei/.local/bin:/home/lei/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export PATH

echo -e "I will use 'touch' command to create 3 files."
read -p "Pleae input your filename: " fileuser

filename=${fileuser:-"filename"} #变数fileuser的内容如果为空或者未设定，由-后面的字符串取代

date1=$(date --date='2 days ago' +%Y%m%d)
date2=$(date --date='1 days ago' +%Y%m%d)
date3=$(date +%Y%m%d)
file1=${filename}${date1}
file2=${filename}${date2}
file3=${filename}${date3}

touch "${file1}"
touch "${file2}"
touch "${file3}"

