#!/bin/bash

# shift_paras.sh: Program shows the effects of shift function.

echo "Total parameter number is ==> $#"
echo "Your whole parameter is ==> '$@'"
shift 
echo "Total parameter number is ==> $#"
echo "Your whole parameter is ==> '$@'"
shift 3 #shift前面的数字3表示去掉最前面的3个参数
echo "Total parameter number is ==> $#"
echo "Your whole parameter is ==> '$@'"
