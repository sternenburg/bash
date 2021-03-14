#!/bin/bash
# while_count: display a series of numbers
count=1
while (( $count <= 5 )); do
	echo $count
	count=$((count + 1))
done
echo "finished."

# while [ $count -le 5 ]; do


