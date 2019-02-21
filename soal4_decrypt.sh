#!/bin/bash

dual=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
duu=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
j="0"
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in /home/gede/modul1/no4/*
do
	key=`echo $i | awk -F "/" '{print $6}'  | awk '{print $1}' | awk -F ":" '{print $1}'`
	key=$((26 - key))
	nama=`echo $i | awk -F "/" '{print$6}'`
	cat $i | tr [${dual:0:26}${duu:0:26}] [${dual:${key}:26}${duu:${key}:26}] > /home/gede/modul1/no4_enc/$nama
	j=$(($j+1))
done

IFS=$SAVEIFS
