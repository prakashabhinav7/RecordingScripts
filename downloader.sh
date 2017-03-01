#!/usr/bin/env bash

while true
do
export IFS=","

#Read in the list of cameras from file "ulist.txt"
cat ulist.txt | while read a b;

#Standardising time format(all images are read in 5 minute intervals). The files are named in multiples #of 5 to make it more standard

do
	mins=$(date +"%M");
	rdr=`expr $mins % 10`;
	c=5;

if [ $rdr -lt $c ]
then
	filename="$(date +%F-%H:%M -d "-$rdr minutes").jpg";
else
	rdr=`expr $rdr - 5`;
	filename="$(date +%F-%H:%M -d "-$rdr minutes").jpg";
fi

foldername=$(date +%Y%m%d)

#Create folder for the day
mkdir -p /var/www/html/CameraFeed/$a/$foldername

#Save the image files to the corressponding day's folder
wget -O /var/www/$filename $b
mv /var/www/$filename /var/www/html/CameraFeed/$a/$foldername

done

sleep 295

done
