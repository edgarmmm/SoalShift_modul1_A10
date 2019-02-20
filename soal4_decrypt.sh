#!/bin/bash

dual=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
duu=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
j="0"
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in /home/gede/modul1/no4/*
do
	echo $i | awk -F "/" '{print $6}'  | awk '{print $1}' | awk -F ":" '{print $1}' > key.txt
	key=$(cat key.txt)
	key=$((26 - key))

	hmm=$(cat $i)
	back=$(echo $hmm | tr "${dual:0:26}" "${dual:${key}:26}")
	back=$(echo $back | tr "${duu:0:26}" "${duu:${key}:26}")

	echo ${back} > /home/gede/modul1/no4_enc/$j.log
	j=$(($j+1))
done

IFS=$SAVEIFS
