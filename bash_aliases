## Aliases
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

#alias ability for 'sudo'
alias sudo="sudo "

#'ls'-magic
alias ls='ls -h --color=auto --group-directories-first'	#->colorfull
alias ll='ls -l'		#->list
alias la='ls -a'		#->all
alias lla='ls -la'		#->list all
alias lx='ls -lXB'		#->sort/extension
alias lz='ls -lSr'		#->sort/size
alias lt='ls -ltr'		#->sort/date
alias lr='ls -R'		#->recursive
alias lm='ls -al|more'		#->piped
alias l='ls'

#'cd'-magic
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'

#'chmod'-magic
alias +r='chmod a+r'
alias ++r='chmod a-r'
alias +w='chmod a+w'
alias ++w='chmod a-w'
alias +x='chmod a+x'
alias ++x='chmod a-x'
alias 000='chmod 000'
alias 640='chmod 640'
alias 644='chmod 644'
alias 750='chmod 750'
alias 755='chmod 755'

#'mount'-magic
alias remount='mount -o remount'

#'dd'-magic
alias readcd='dd if=/dev/cdrom of=cdrom.iso'
alias readdvd='dd if=/dev/dvd of=dvd.iso'
alias writecd='dd if=cdrom.iso of=/dev/cdrecorder'
alias writedvd='dd if=dvd.iso of=/dev/cdrecorder'

#'make'-magic
alias doflash='make clean && make all && make flash'
alias doinstall='make clean && make all && make install'
alias doit='make clean && make all'
alias doprogram='make clean && make all && make program'

#'grep'-magic
alias dgrep='dmesg|grep -i'
alias hgrep='history|grep'
alias mgrep='cat /var/log/messages|grep -i'
alias sgrep='cat /var/log/syslog|grep -i'

#'tail'-magic
alias dtail='dmesg|tail'
alias mtail='cat /var/log/messages|tail'
alias stail='cat /var/log/messages|tail'

#save overwrite & verbose output
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -v'
alias rmdir='rmdir -v'

#human readable
alias df='df -Th'
alias du='du -h'
alias datetime='date "+%A, %d-%m-%Y - %T %Z"'
alias which='type -a'
alias perm='stat --printf "%a %n \n"'

#'ping'-limit
alias ping='ping -c 3'

#'slocate'
alias slocup='sudo slocate -U /'

#comfort fileoperations
alias rscp='rsync -aP --inplace --no-whole-file'
alias rsmv='rscp --remove-source-files'
alias open='kfmclient exec'

#listings
alias lsofn='lsof | awk "!/^\$/ && /\// { print \$9 }" | sort -u'
alias lsofip='lsof -i'
alias lsusbn='lsusb 2>&1 | grep -v "libusb: debug"'

#links
alias linksfb='links -driver fb'
alias linksdump='links -dump'

#'netstat'
alias netstat80="netstat -plan|grep :80|awk {'print $5'}|cut -d: -f 1|sort|uniq -c|sort -nk 1"
alias netstatports="netstat -nape --inet"
alias netstatpid="netstat -tlnp"
alias netstatapps="netstat -lantp | grep -i stab | awk -F/ '{print $2}' | sort | uniq"

#'iptables'
alias iptstat='sudo iptables -L -v'
alias iptsave='sudo /etc/init.d/iptables save'
alias conntrack='sudo cat /proc/net/ip_conntrack'

#pathes
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias ldpath='echo $DYLD_LIBRARY_PATH | tr ":" "\n"'
alias clpath='echo $CLASSPATH | tr ":" "\n"'
#alias sudo='sudo '	#function seems to be better

#watching
alias wdf='watch df'
alias wfree='watch free'
alias wmount='watch mount'
alias wsensor='watch sensors'

#other
alias woman='man'
alias shot='import -frame -strip -quality 75 "$HOME/$(date +%s).png'
alias genmac='for ((i=0;i<6;i++)); do printf "%2.0x" $[$RANDOM%239+16]; [ $i -lt 5  ] && echo -n :; done; echo'

#/proc
alias loadavg='cat /proc/loadavg'

# NOTE
#####################################################
# To bypass an alias, preceed the command with a '\'
# EG:  >ls< is aliased, to use the normal "ls":  \ls
