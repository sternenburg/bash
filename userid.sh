#!/bin/bash

#userid.sh: Use id, finger command to check system account's information

users=$(cut -d ':' -f1 /etc/passwd)
for username in ${users}
# for username in lei bei
do
	id {username}
done

