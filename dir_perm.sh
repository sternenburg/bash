#!/bin/bash
# dir_perm.sh: User inputs a dir name, program finds the permission of files.

# 1. 检查目录是否存在
read -p "Please input a directory: " dir
if [ "${dir}" == "" -o ! -d "${dir}" ]; then
	echo "The ${dir} does not exist."
	exit 1
fi

# 2. 开始测试
filelist=$(ls ${dir}) # 列出该目录下的所有文件
for filename in ${filelist}
do
	perm=""
	test -r "${dir}/${filename}" && perm="${perm} readable"
	test -w "${dir}/${filename}" && perm="${perm} writable"
	test -x "${dir}/${filename}" && perm="${perm} executable"
	echo "The file ${dir}/${filename}'s permission is${perm}"
done
