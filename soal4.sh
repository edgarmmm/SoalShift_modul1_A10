#!/bin/bash

dual=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
duu=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

phrase=$(cat /var/log/syslog)
date | awk -F ":" '{print $1}' | awk '{print $4}' > jam.txt
rotat=$(cat jam.txt)
date | awk '{print $4}' | awk -F ":" '{print $1":"$2}' > jam2.txt
jam=$(cat jam2.txt)
date | awk '{print $3"-"$2"-"$6}' > tanggal.txt
tanggal=$(cat tanggal.txt)

newphrase=$(echo $phrase | tr "${dual:0:26}" "${dual:${rotat}:26}")
newphrase=$(echo $newphrase | tr "${duu:0:26}" "${duu:${rotat}:26}")

echo ${newphrase} > /home/gede/modul1/no4/$jam\ $tanggal.log
