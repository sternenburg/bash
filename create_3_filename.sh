#!/bin/bash
# create_3_filename.sh: Creates 3 files, which named by user's input and date command.

# 1. 让使用者输入档案名称，并取得fileuser这个变量
echo -e "I will use 'touch' command to create 3 files."
read -p "Please input your filename: " fileuser

# 2. 为了避免使用者随意按Enter，分析文件名是否被设定
filename=${fileuser:-"filename"} # 如果文件名没有设定或者为空，则设置为默认文件名

# 3. 利用date命令获取所需的文件名
date1=$(date --date='2 days ago' +%Y%m%d) #前两天的日期
date2=$(date --date='1 days ago' +%Y%m%d) #前一天的日期
date3=$(date +%Y%m%d)	#今天的日期
file1=${filename}${date1}
file2=${filename}${date2}
file3=${filename}${date3}

# 4. 建立档案
touch "${file1}"
touch "${file2}"
touch "${file3}"

