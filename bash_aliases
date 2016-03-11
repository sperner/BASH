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
alias lh='ls -lh'		#->humanreadable
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
alias mounttab='echo "DEVICE PATH TYPE FLAGS" && mount | awk \$2=\$4=\"\"\;2 | column -t'

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
alias cgrep='sudo cat /var/log/cron.log|grep -i'
alias dgrep='sudo cat /var/log/daemon.log|grep -i'
alias hgrep='cat ~/.bash_history|grep -i'
alias kgrep='sudo cat /var/log/kern.log|grep -i'
alias mgrep='sudo cat /var/log/messages|grep -i'
alias sgrep='sudo cat /var/log/syslog|grep -i'
alias xgrep='sudo cat /var/log/Xorg.0.log|grep -i'

#'tail'-magic
alias ctail='sudo cat /var/log/cron.log|tail'
alias dtail='sudo cat /var/log/daemon.log|tail'
alias ktail='sudo cat /var/log/kern.log|tail'
alias mtail='sudo cat /var/log/messages|tail'
alias stail='sudo cat /var/log/syslog|tail'
alias xtail='sudo cat /var/log/Xorg.0.log|tail'

#save overwrite & verbose output
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias ln='ln -v'
alias mkdir='mkdir -v'
alias rmdir='rmdir -v'
alias chmod='chmod -v'
alias chgrp='chgrp -v'
alias chown='chown -v'
alias modprobe="modprobe -v"

#human readable
alias df='df -Th'
alias du='du -h'
alias free='free -h'
alias datetime='date "+%A, %d-%m-%Y - %T %Z"'
alias which='type -a'
alias perm='stat --printf "%a %n \n"'

#'ping'-limit
alias ping='ping -c 3'

#'slocate'
alias slocup='sudo slocate -U /'

#memory
alias memusage='ps -eo command,size --sort -size|grep -v ' 0''

#comfort fileoperations
alias rscp='rsync -aP --inplace --no-whole-file'
alias rsmv='rscp --remove-source-files'
alias open='kfmclient exec'

#listings
alias lsofn='lsof | awk "!/^\$/ && /\// { print \$9 }" | sort -u'
alias lsofip='lsof -i'
alias lsusbn='lsusb 2>&1 | grep -v "libusb: debug"'

#'links'
alias linksfb='links -driver fb'
alias linksdump='links -dump'

#'wget'
alias wgettrack="wget --random-wait -r -l 0 -p -e robots=off -U Mozilla"

#'netstat'
alias netstat80="netstat -plan|grep :80|awk {'print $5'}|cut -d: -f 1|sort|uniq -c|sort -nk 1"
alias netstatports="netstat -nape --inet"
alias netstatpid="netstat -tlnp"
alias netstatapps="netstat -lantp | grep -i stab | awk -F/ '{print $2}' | sort | uniq"

#'iptables'
alias igrep='sudo cat /var/log/iptables.log|grep -i'
alias iptstat='sudo iptables -L -v'
alias iptsave='sudo /etc/init.d/iptables save'
alias itail='sudo cat /var/log/iptables.log|tail'
alias conntrack='sudo cat /proc/net/ip_conntrack'

#pathes
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias ldpath='echo $DYLD_LIBRARY_PATH | tr ":" "\n"'
alias clpath='echo $CLASSPATH | tr ":" "\n"'

#watching
alias wdf='watch df'
alias wfree='watch free'
alias wmount='watch mount'
alias wsensor='watch sensors'

#other
alias woman='man'
alias shot='import -frame -strip -quality 75 "$HOME/$(date +%s).png'
alias genmac='for ((i=0;i<6;i++)); do printf "%2.0x" $[$RANDOM%239+16]; [ $i -lt 5  ] && echo -n :; done; echo'
alias getkeyboards="grep -E 'Handlers|EV=' /proc/bus/input/devices | grep -B1 'EV=120013' | grep -Eo 'event[0-9]+'"
alias discusage="du -sh /* 2>/dev/null|sort -h"

#/proc
alias loadavg='cat /proc/loadavg'

# NOTE
#####################################################
# To bypass an alias, preceed the command with a '\'
# EG:  >ls< is aliased, to use the normal "ls":  \ls
