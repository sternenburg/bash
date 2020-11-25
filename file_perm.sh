#!/bin/bash
# file_perm.sh: User input a filename, program will check the following:
# 1) exist? 2) file or directory? 3) file permissions

# 1. 使用者输入文件名，并且判断使用者是否有输入字符串
echo -e "Please input a filename, I will check the filename's type and permission. \n\n"
read -p "Input a filename : " filename
test -z ${filename} && echo "You must input a filename." && exit 0

# 2. 判断文件是否存在，如果不存在则显示信息并结束脚本
test ! -e ${filename} && echo "The filename '${filename}' DO NOT exist" && exit 0

# 3. 判断文件类型与属性
test -f ${filename} && filetype="regular file"
test -d ${filename} && filetype="directory"
test -r ${filename} && perm="readable"
test -w ${filename} && perm="${perm} writable"
test -x ${filename} && perm="${perm} executable"

# 4. 开始输入信息
echo "The filename: ${filename} is a ${filetype}"
echo "And the permission for you are: ${perm}"

