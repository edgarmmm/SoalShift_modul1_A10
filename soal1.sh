#!/bin/bash
unzip /home/gede/modul1/nature.zip -d /home/gede/modul1
i="0"
for j in /home/gede/modul1/nature/*.jpg
do
	base64 -d $j | xxd -r > /home/gede/modul1/naturego/$i.jpg
	i=$(($i+1))
done
