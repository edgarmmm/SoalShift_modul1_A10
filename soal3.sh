#!/bin/bash
i="0"
for p in /home/gede/modul1/no3/password*.txt
do
	pass[$i]=$(cat $p)
	i=$(($i+1))
done
flag="0"
a="1"
while true
do
	file="/home/gede/modul1/no3/password$a.txt"
	if [ -f "$file" ]
	then
		a=$(($a+1))
	else
		pw=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12`
		for j in pass[*]
		do
			if [ $pw != $j ]
			then
				flag="1"
			fi
		done
		if [ $flag -eq 1 ]
		then
			echo $pw > /home/gede/modul1/no3/password$a.txt
			break
		fi
	fi
done
