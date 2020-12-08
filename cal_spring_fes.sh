#!/bin/bash

# cal_spring_fest.sh: Program calculate how many days left before the 2021 spring festival

declare -i date_now=$(date +%s) # 现在的秒数
declare -i date_spring_s=$(date --date="20210212" +%s) #2021年春节的秒数
declare -i date_total_s=$((${date_spring_s}-${date_now})) #离过年剩余的秒数
declare -i date_d=$((${date_total_s}/60/60/24)) # 转换为剩余的天数
echo "There are ${date_d} days left before the 2021 spring festival."

