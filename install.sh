#!/bin/sh
#
# Install script for bash stuff
#


echo "Copying bash file"
for file in $(ls bash*)
do
	cp -v $file ~/.$file
done


echo "Copying some usefull scripts"
if [ ! -d ~/.bin ]
then
	mkdir -v ~/.bin
fi

if [ -d ~/.bin ]
then
	cp -v {brightness,colors,dokernel,eedit,mute,revlookup,volume,wondershaper} ~/.bin/
fi
