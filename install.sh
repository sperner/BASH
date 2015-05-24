#!/bin/sh
#
# Install script for bash stuff
#


if [[ $1 == "all" ]]
then
	if [ -d /etc/bash ]
	then
		echo "Copying global bashrc"
		sudo cp etc.bashrc /etc/bash/bashrc
	fi
fi


echo "Copying bash files"
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

