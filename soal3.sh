#!/bin/bash

a="1"
while true
do
	file="/home/gede/modul1/no5/password$a.txt"
	if [ -f "$file" ]
	then
		a=$(($a+1))
	else
		head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 > modul1/no5/password$a.txt
		break
	fi
done
