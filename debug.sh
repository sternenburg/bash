#!/bin/bash
# debug.sh: Program to show how to debug

for i in {1..6};
do
	set -x
	echo $i
	set +x
done
echo "Script executed"

