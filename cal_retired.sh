#!/bin/bash

# cal_retired.sh: Program calculates how many days left before you demobilize

# 1. 告知程序用途，同时告知如何输入
echo "This program will try to calculate :"
echo "How many days left before your demobilization date.."
read -p "Please input your demobilization date (YYYYMMDD ex>20150716) : " date2

# 2. 测试一下输入格式是否正确
date_d=$(echo ${date2} | grep '[0-9]\{8\}') # 测试是否是8位数字
if [ "${date_d}" == "" ]; then
	echo "You input the wrong date format ..."
	exit 1
fi

# 3. 开始计算日期
declare -i date_dem=$(date --date="${date2}" +%s)	# 退伍日期秒数
declare -i date_now=$(date +%s)				# 现在日期秒数
declare -i date_total_s=$((${date_dem}-${date_now}))	# 剩余秒数
declare -i date_d=$((${date_total_s}/60/60/24))		# 转换为天数
if [ "${date_total_s}" -lt "0" ]; then
	echo "You had been dembilization before: " $((-1*${date_d})) " ago"
else
	declare -i date_h=$(($((${date_total_s}-${date_d}*60*60*24))/60/60))
	echo "You will demobilize after ${date_d} days and ${date_h} hours."
fi

