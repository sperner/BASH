#!/bin/sh
#
# Install script for bash stuff
# Author: Sven Sperner <cethss@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

DISTROS="arch debian gentoo"
SCRIPTS="brightness colors dokernel eedit healthchk mute power revlookup volume wondershaper"

if [[ $1 == "all" ]]
then
	if [ -d /etc/bash ]
	then
		echo -e "\033[1;37m Copying global bashrc \033[0m"
		sudo cp etc.bashrc /etc/bash/bashrc
	fi
fi

echo -e "\033[1;37m Copying bash files \033[0m"
for file in $(ls bash*)
do
	cp -v $file ~/.$file
done

echo -e "\033[1;37m Copying some usefull scripts \033[0m"
if [ ! -d ~/.bin ]
then
	mkdir -v ~/.bin
fi
if [ -d ~/.bin ]
then
	for script in ${SCRIPTS}
	do
		cp -v $script ~/.bin/
	done
fi

echo -e "\033[1;37m Copying bash completion(s) \033[0m"
if [ ! -d ~/.bash_completion.d ]
then
	mkdir -v ~/.bash_completion.d
fi
if [ -d ~/.bash_completion.d/ ]
then
	cp -v *.bashcomp ~/.bash_completion.d/
fi

echo -e "\033[1;37m Copying distribution specific \033[0m"
for distri in ${DISTROS}
do
	if (cat /etc/os-release | grep -i $distri 2>&1 1>/dev/null)
	then
		cp -v xbash_$distri ~/.bash_$distri
		cp -v xbash_login.$distri ~/.bash_login
	fi
done

echo -e "\033[1;32m Installation completed,\033[0;32m have fun!\033[0m\n"
