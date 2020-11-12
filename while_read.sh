#!/bin/bash

# while_read.sh: read lines from a file.
# this is a test info

while read distro version release; do
	printf "Distro: %s\tVersion: %s\tReleased: %s\n" \
		$distro \
		$version \
		$release
done < ~/distros.txt
