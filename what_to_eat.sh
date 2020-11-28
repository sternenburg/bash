#!/bin/bash

# what_to_eat.sh: Program tells you what to eat by using random numbers

# 如果用 $sh what_to_eat.sh 执行的话会报错，因为 RANDOM 是bash函数，在dash里还没有声明
# 用 $bash what_to_eat.sh 执行就没有错误

# 1. 创建选择的数组

eat[1]="肯德基"
eat[2]="食堂"
eat[3]="振鼎鸡"
eat[4]="呷哺"
eat[5]="泡面"
eat[6]="饺子"
eat[7]="包子"
eat[8]="烧饼"
eat[9]="烤鱼"
eat[10]="麻辣烫"
eat[11]="东北菜"

eatnum=11

# 2. 生成随机数

eated=0
while [ "${eated}" -lt 3 ]; do
	
	check=$(( ${RANDOM}*${eatnum}/32767 + 1 )) # 生成1-11之间的随机数
	mycheck=0

	if [ "${eated}" -ge 1 ]; then # 如果eated大于等于1
		for i in $(seq 1 ${eated}) 
		do
			if [ ${eatedcon[$i]} == $check ]; then # 如果菜单重复，则重新生成随机数
				mycheck=1
			fi
		done
	fi
	if [ ${mycheck} == 0 ]; then
		echo "You my eat ${eat[${check}]}, the number is ${check}."
		eated=$(( ${eated} + 1 ))
		eatedcon[${eated}]=${check} # 将出现的选择号码存到eatedcon数组中
	fi
done

		
