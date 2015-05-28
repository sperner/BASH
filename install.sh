#!/bin/sh
#
# Install script for bash stuff
#


DISTROS="arch debian gentoo"


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


echo "Copying distribution specific"
for distri in ${DISTROS}
do
	if (cat /etc/os-release | grep -i $distri 2>&1 1>/dev/null)
	then
		cp -v xbash_$distri ~/.bash_$distri
		cp -v xbash_login.$distri ~/.bash_login
	fi
done
