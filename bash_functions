## Functions
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

## Common Functions
ask()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Ask if something should be done and return 0/1"
		echo -e "${RED}usage:${BLUE} ask() <question>" && return;
	fi
	echo -n "$@" '[y/n] ' ; read ans
	case "$ans" in
		y*|Y*) return 0 ;;
		*) return 1 ;;
	esac
}

clock()
{
	[ $# -gt 0 ] && echo "Show Clock"
	while true;do
		clear;
		echo -e "${blue}==========${CYAN}";
		echo -n " "; date +"%r";
		echo -e "${blue}==========${nocol}";
		sleep 1;
	done;
}

repeat()
{
	if [ "$#" -lt 2 ]; then
		echo -e "Repeat a given command n-times"
		echo -e "${RED}usage:${BLUE} repeat() <n> <program>${blue} [<param1> <...>]" && return;
	fi
	local i max
	max=$1; shift;
	for ((i=1; i <= max ; i++)); do
		eval "$@";
	done
}

man2pdf()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Generate PDF dokument from man-page"
		echo -e "${RED}usage:${BLUE} man2pdf() <site>" && return;
	fi
	man -t $1 | ps2pdf - > $1.pdf
}

bu()
{
        if [ "$#" -lt 1 ]; then
                echo -e "Backup a file (append date to name)"
                echo -e "${RED}usage:${BLUE} bu() <filepath>" && return;
        fi
	cp $1 ${1}-`date +%Y%m%d%H%M`.backup ;
}

isNumeric()
{
	if ! [[ "$1" =~ ^-*[0-9]+([.][0-9]+)?$ ]]
	then
		if ! [[ "$1" =~ ^-*[0-9]+([,][0-9]+)?$ ]]
		then
			return 1
		else
			return 0
		fi
	else
		return 0
	fi
}



## Daemon Functions
start()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Start a Daemon via Initscript"
		echo -e "${RED}usage:${BLUE} start() <scriptname>" && return;
	fi
	for arg in $*; do
		sudo /etc/init.d/$arg start;
	done
}

stop()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Stop a Daemon via Initscript"
		echo -e "${RED}usage:${BLUE} stop() <scriptname>" && return;
	fi
	for arg in $*; do
		sudo /etc/init.d/$arg stop;
	done
}

restart()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Restart a Daemon via Initscript"
		echo -e "${RED}usage:${BLUE} restart() <scriptname>" && return;
	fi
	for arg in $*; do
		sudo /etc/init.d/$arg restart;
	done
}

reload()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Reload Configuration of a Daemon via Initscript"
		echo -e "${RED}usage:${BLUE} reload() <scriptname>" && return;
	fi
	for arg in $*; do
		sudo /etc/init.d/$arg reload;
	done
}

status()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Show status of a Daemon via Initscript"
		echo -e "${RED}usage:${BLUE} status() <scriptname>" && return;
	fi
	for arg in $*; do
		sudo /etc/init.d/$arg status;
	done
}



#Signal/Kill Functions
sigkill()
{
        if [ "$#" -lt 1 ]; then
                echo -e "Send KILL - Signal to a process"
                echo -e "${RED}usage:${BLUE} sigkill() <name/id>" && return;
        fi
	if [[ "$1" =~ ^[0-9]+$ ]]
	then
		kill -9 $1
	else
		killall -9 $1
	fi
}

sigcont()
{
        if [ "$#" -lt 1 ]; then
                echo -e "Send CONTINUE - Signal to a process"
                echo -e "${RED}usage:${BLUE} sigcont() <name/id>" && return;
        fi
	if [[ "$1" =~ ^[0-9]+$ ]]
	then
		kill -18 $1
	else
		killall -18 $1
	fi
}

sigstop()
{
        if [ "$#" -lt 1 ]; then
                echo -e "Send STOP - Signal to a process"
                echo -e "${RED}usage:${BLUE} sigstop() <name/id>" && return;
        fi
	if [[ "$1" =~ ^[0-9]+$ ]]
	then
		kill -19 $1
	else
		killall -19 $1
	fi
}



## Shell... Functions
add2path()
{
	if [ $# -lt 1 ] || [ $# -gt 2 ]; then
		echo -e "Temporarily add a directory to PATH-variable"
		echo -e "${RED}usage:${BLUE} apath() <directory>"
	else
		PATH=$1:$PATH
	fi
}

printtitle()
{
	PROMPT_COMMAND="echo -ne '\033]0;$@\007'"
}

chgroot()
{
	if [ $# -lt 1 ]
	then
		echo -e "Bind virtual filesystems and change root"
		echo -e "${RED}usage:${BLUE} chgroot() <directory>"
	else
		sudo mount -t proc /proc $1/proc	|| echo "$0: ${RED}Mounting /proc failed"; exit -1
		sudo mount --rbind /dev $1/dev		|| echo "$0: ${RED}Mounting /dev failed"; exit -1
		sudo mount --rbind /sys $1/sys		|| echo "$0: ${RED}Mounting /sys failed"; exit -1
		sudo chroot $1 /bin/bash		|| echo "$0: ${RED}Changing root failed"; exit -1
	fi
}



#Date/Time Functions
time2summer()
{
	sudo date $(date +%m%d)$[$(date +%H)+1]$(date +%M%Y.%S)
}

time2winter()
{
        sudo date $(date +%m%d)$[$(date +%H)-1]$(date +%M%Y.%S) 
}



## Process... Functions
runs()
{
	if [ $# -gt 0 ]
	then
		ps -elf | grep -v grep | grep $1
	else
		echo -e "Does a given process run?"
		echo -e "${RED}usage:${BLUE} runs()${blue} [<string>]"
	fi
}

pp()
{
	[ $# -gt 0 ] && echo "Show personalised _ps_"
	ps $@ -u $USER -o pid,%cpu,%mem,tty,bsdtime,command ;
}

ppe()
{
	[ $# -gt 0 ] && echo "Show personalised, extended _ps_"
	pp f | awk '!/awk/ && $0~var' var=${1:-".*"} ;
}

killps()
{
	local pid pname sig="-TERM"			# Default signal
	if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
		echo -e "Kill by process name"
		echo -e "${RED}usage: ${BLUE}killps${blue} [-SIGNAL]${BLUE} <pattern>"
		return;
	fi
	if [ $# = 2 ]; then sig=$1 ; fi
	for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
		pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
		if ask "Kill process $pid <$pname> with signal $sig?"
			then kill $sig $pid
		fi
	done
}

killin()
{
	if [ $# -eq 2 ]; then
		sleep $(calc 60*$2)
		kill -9 $(ps -e | grep -i $1 | cut -d" " -f2)
	else
		echo -e "Kill by process name in given time"
		echo -e "${RED}usage: ${BLUE}killin <seconds>"
	fi
}

#workaround for not having 'gcore'
#gcore()
#{
#	j=$#
#	for ((i=0;i<$j;i++));
#	do
#		echo "i:$i  -  $1"
#		shift
#	done
#	sudo gdb --pid=$1 --batch -ex gcore
#}



## File... Functions
parse()
{
	if [ $# -eq 2 ]
	then
		grep -iR $2 $1
	else
		echo -e "Parse File(s) for String and PrintOut"
		echo -e "${RED}usage:${BLUE} parse() <File/Path2Parse> <String2Look4>"
	fi
}

lsofp()
{
	if [ "$1" == "--help"  ]; then
		echo -e "Find file(s) opened by process"
		echo -e "${RED}usage:${BLUE} lsofp() <processname>" && return;
	fi
	for ((i=2;i<=5;i++));
	do
		PID=`ps -e|grep -i " ${1:-init}"|cut -d\  -f$i`
		if [ $PID -ge 1 ] 2>/dev/null; then
			break
		fi	
	done
	lsof +p $PID|sort -k 9
}

lsofu()
{
	if [ "$1" == "--help" ]; then
		echo -e "List usage of files used by process"
		echo -e "${RED}usage:${BLUE} lsofu() <processname>" && return;
	fi
	for ((i=2;i<=5;i++));
	do
		PID=`ps -e|grep -i " ${1:-init}"|cut -d\  -f$i`
		if [ $PID -gt 0 ] 2>/dev/null; then
			echo "got pid $PID"
			break
		else
			echo "no pid at $i"
		fi
	done
	strace -e trace=file -p $PID
}

fls()
{
	if [ "$1" == "--help" ]; then
		echo -e "List files & directories with the full path"
		echo -e "${RED}usage:${BLUE} fls() [<path>]" && return;
	fi
	find ${1:-.} -maxdepth 1
}

ff()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Find (a) file(s) with a specific pattern in name"
		echo -e "${RED}usage:${BLUE} ff() <question>" && return;
	fi
	find . -type f -iname '*'$*'*' -ls;
}

ffe()
{
	if [ "$#" -lt 2 ]; then
		echo -e "Find (a) file(s) with pattern and execute command on it"
		echo -e "${RED}usage:${BLUE} ffe() <pattern> <command>${blue} [<param1> <...>]" && return;
	fi
	find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ;
}

fsif()
{
	OPTIND=1
	local case=""
	if [ "$#" -lt 1 ]; then
		echo -e "Find a pattern in a set of files and highlight them"
		echo -e "${RED}usage:${BLUE} fsif() [-i] <pattern>${blue} [<filename-pattern>]" && return;
	fi
	while getopts :it opt
	do
		case "$opt" in
		i) case="-i " ;;
		*) echo "$usage"; return;;
		esac
	done
	shift $(( $OPTIND - 1 ))
	find . -type f -name "${2:-*}" -print0 | xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more 
}

cbt()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Count files by type"
		echo -e "${RED}usage:${BLUE} cbt() <filename-pattern>" && return;
	fi
	find ${*-.} -type f -print0 | xargs -0 file | awk -F, '{print $1}' | awk '{$1=NULL;print $0}' | sort | uniq -c | sort -nr ;
}

2Lowercase()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Change filename(s) to lowercase"
		echo -e "${RED}usage:${BLUE} 2Lowercase() <filename-pattern>" && return;
	fi
	for i in "$@"; do mv -f "$i" "`echo $i| tr [A-Z] [a-z]`" &>/dev/null; done
}

2Uppercase()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Change filename(s) to uppercase"
		echo -e "${RED}usage:${BLUE} 2Uppercase() <filename-pattern>" && return;
	fi
	for i in "$@"; do mv -f "$i" "`echo $i| tr [a-z] [A-Z]`" &>/dev/null; done
}

space2underscore()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Change filename(s) spaces to underscores"
		echo -e "${RED}usage:${BLUE} space2underscore() <filename-pattern>" && return;
	fi
	for i in "$@"; do mv "$i" "`echo $i| tr ' ' '_'`" &>/dev/null; done
}

lowercase()  # move filenames to lowercase
{
	if [ "$#" -lt 1 ]; then
		echo -e "Change filename(s) to lowercase"
		echo -e "${RED}usage:${BLUE} lowercase() <filename-pattern>" && return;
	fi
	for file ; do
		filename=${file##*/}
		case "$filename" in
		*/*) dirname==${file%/*} ;;
		*) dirname=.;;
		esac
		nf=$(echo $filename | tr A-Z a-z)
		newname="${dirname}/${nf}"
		if [ "$nf" != "$filename" ]; then
			mv "$file" "$newname" && echo "lowercase: $file --> $newname"
		else
			echo "lowercase: $file not changed."
		fi
	done
}

swap()  # Swap 2 filenames around, if they exist
{                #(from Uzi's bashrc).
    local TMPFILE=tmp.$$ 
    [ $# -ne 2 ] && echo -e "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo -e "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo -e "swap: $2 does not exist" && return 1
    mv "$1" $TMPFILE 
    mv "$2" "$1"
    mv $TMPFILE "$2"
}



## Archive... Functions
mktar()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Create a Tar-Archive"
		echo -e "${RED}usage:${BLUE} mktar() <path>" && return;
	fi
	tar cvf  "${1%%/}.tar"     "${1%%/}/";
}

mktgz()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Create a Tar/GZIP-Archive"
		echo -e "${RED}usage:${BLUE} mktgz() <path>" && return;
	fi
	tar cvzf "${1%%/}.tar.gz"  "${1%%/}/";
}

mktbz()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Create a Tar/BZIP2-Archive"
		echo -e "${RED}usage:${BLUE} mktbz() <path>" && return;
	fi
	tar cvjf "${1%%/}.tar.bz2" "${1%%/}/";
}

mktxz()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Create a Tar/XZ-Archive"
		echo -e "${RED}usage:${BLUE} mktxz() <path>" && return;
	fi
	tar cvJf "${1%%/}.tar.xz" "${1%%/}/";
}

extract ()
{
    if [ -f $1 ] ; then
	case $1 in
	*.tar.bz2)   tar xjvf $1	;;
	*.tar.gz)    tar xzvf $1	;;
	*.tar.xz)    tar xJvf $1	;;
	*.bz2)       bunzip2 -v $1	;;
	*.rar)       unrar x $1		;;
	*.gz)        gunzip -v $1	;;
	*.tar)       tar xvf $1		;;
	*.tbz2)      tar xjvf $1	;;
	*.tgz)       tar xzvf $1	;;
	*.zip)       unzip $1		;;
	*.Z)         uncompress -v $1	;;
	*.7z)        7z x $1		;;
	*.arj)       unarj $1		;;
	*.lzma)      unlzma -v $1	;;
	*.lzop)      tar --lzop xvf $1	;;
	*.lzip)      tar --lzip xvf $1	;;
	*)           echo -e "${red} extract() does not know the extension of ${blue}$1" ;;
    esac
  else
    echo -e "\n${red}'$1' ${RED}usage:${BLUE} extract() <archive>"
  fi
}



## Mount... Functions
mountusb()
{
	if [ "$#" -gt 0 ]; then
		echo -e "Mount a Filesystem to /media/usb"
		echo -e "${RED}usage:${BLUE} mountusb() [<device>]";
	fi
	mount ${1:-/dev/sdb1} /media/usb && echo -e "${BLUE}$0: ${blue}${1:-/dev/sdb1} mounted"
}

mountiso()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Mount an ISO-Imagefile to /media/iso"
		echo -e "${RED}usage:${BLUE} mountiso() <iso-file>" && return;
	fi
	mount -o loop -t iso9660 $1 /media/iso && echo -e "${BLUE}$0: ${blue}$1 mounted"
}

mountimg()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Mount an Imagefile (HD,...) to /media/img"
		echo -e "${RED}usage:${BLUE} mountimg() <img-file>" && return;
	fi
	mount -o loop $1 /media/img && echo -e "${BLUE}$0: ${blue}$1 mounted"
}

mountnfs()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Mount an NFS-Share to /media/nfs"
		echo -e "${RED}usage:${BLUE} mountnfs() <[host]:[path]>" && return;
	fi
	mount -t nfs $1 /media/nfs && echo -e "${BLUE}$0: ${blue}$1 mounted"
}

mountsshfs()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Mount an SSH/FS-Path to /media/nfs"
		echo -e "${RED}usage:${BLUE} mountsshfs() <[user]@[host]:[path]>" && return;
	fi
	sshfs $1 /media/sshfs && echo -e "${BLUE}$0: ${blue}$1 mounted at /media/sshfs"
}

mountntfs()
{
	if [ "$#" -gt 0 ]; then
		echo -e "Mount an NTFS-Filesystem to /media/ntfs"
		echo -e "${RED}usage:${BLUE} mountntfs() [<device>]";
	fi
	ntfs-3g ${1:-/dev/sdb1} /media/ntfs && echo -e "${BLUE}$0: ${blue}$1 mounted"
}

mountboot()
{
        if [ "$#" -gt 0 ]; then
                echo "Mount the Boot-Partition to /boot"
                echo "${RED}usage:${BLUE} mountboot() [<device>]";
        fi
	sudo mount ${1:-/dev/sda1} /boot && echo -e "${BLUE}$0: ${blue}${1:-/dev/sda1} mounted"
}



## Network... Functions
netinfo ()
{
	echo "--------------- Network Information ---------------"
	/sbin/ifconfig | awk /'inet Adr/ {print $2}'
	/sbin/ifconfig | awk /'Bcast/ {print $3}'
	/sbin/ifconfig | awk /'inet Adr/ {print $4}'
	#/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
	cat /etc/resolv.conf | awk /'nameserver/ {print $1,$2}'
	echo "---------------------------------------------------"
}

hostinfo()
{
	[ $# -gt 0 ] && echo "Get current host related info"
	echo -e "\n${YELLOW}You are logged on ${RED}$HOST"
	echo -e "\n${RED}Current date :$NC ${BLUE}" ; datetime
	echo -e "\n${RED}Temperatures:$NC ${BLUE}" ; sensors|grep C --color=never
	echo -e "\n${RED}Kernel information:$NC ${BLUE}" ; uname -a
	echo -e "\n${RED}Users logged on:$NC ${BLUE}" ; w -h
	echo -e "\n${RED}Machine stats :$NC ${BLUE}" ; uptime
	echo -e "\n${RED}Memory stats :$NC ${BLUE}" ; free
	localip 2>&- ;
	echo -e "\n${RED}Local IP Address :$NC ${BLUE}" ; echo ${MY_IP:-"Not connected"}
	echo -e "\n${RED}ISP Address :$NC ${BLUE}" ; echo ${MY_ISP:-"Not connected"}
	echo -e "\n${RED}Open connections :$NC ${BLUE}"; netstat -pan --inet;
	echo
}

chmac()
{
	if [ "$#" -lt 2 ]; then
		echo -e "Change ethernet MAC of a network interface"
		echo -e "${RED}usage:${BLUE} chmac() <interface> <newMAC(xx:xx:xx...)>" && return;
	fi
	sudo ifconfig $1 hw ether $2 && echo -e "Interface:${green}$1 ${nocol}set to ${red}$2"
}

localip()
{
	[ $# -gt 0 ] && echo -e "Get IP adresses"
#	MY_IP=$(/sbin/ifconfig ppp0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
#	MY_ISP=$(/sbin/ifconfig ppp0 | awk '/P-t-P/ { print $3 } ' | sed -e s/P-t-P://)
	MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
#	MY_ISP=$(pubip)
}

pubip()
{
	[ $# -gt 0 ] && echo -e "Get public IP-Address"
	wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//';
}

getserver()
{
	[ $# -gt 0 ] && echo -e "Get Server-Information"
	curl -I $1  2>&1 | grep Server;
}

respond()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Respondtime to a Server"
		echo -e "${RED}usage:${BLUE} respond() <url>" && return;
	fi
	curl -o /dev/null -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" $1;
}

wdl()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Wget-Download"
		echo -e "${RED}usage:${BLUE} wdl() <url>" && return;
	fi
	wget -r -l5 -k -E ${1} && cd $_;
}

defger()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Print the definition of a german Word"
		echo -e "${RED}usage:${BLUE} defger() <word>" && return;
	fi
	local y="$@";curl -sA"Opera" "http://www.google.de/search?q=define:${y// /+}"|grep -Po '(?<=<li>)[^<]+'|nl|perl -MHTML::Entities -pe 'decode_entities($_)' 2>/dev/null;
}

defeng()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Print the definition of an english Word"
		echo -e "${RED}usage:${BLUE} defeng() <word>" && return;
	fi
	local y="$@";curl -sA"Opera" "http://www.google.com/search?q=define:${y// /+}"|grep -Po '(?<=<li>)[^<]+'|nl|perl -MHTML::Entities -pe 'decode_entities($_)' 2>/dev/null;
}

macinfo()
{
	if [ $# -gt 0 ]; then
		MAC=$(echo $1 | sed 's/:/-/g')
		links -dump http://standards.ieee.org/cgi-bin/ouisearch?$MAC
	else
		echo -e "Get information about the hardware manufacturer via MAC"
		echo -e "${RED}usage:${BLUE} macinfo() <MAC (\"xx-xx-xx\" or \"xx:xx:xx\")>"
		echo -e "first three bytes are enough, less bytes result in a list"
	fi
}

translate()
{
	if [ $# -gt 0 ]; then
		ENG=$(curl -sA"Opera" "http://www.dict.cc/?s=$1"|grep --colour=auto Array|head -2|tail -1|sed 's/\ /_/g')
		GER=$(curl -sA"Opera" "http://www.dict.cc/?s=$1"|grep --colour=auto Array|head -3|tail -1|sed 's/\ /_/g')
		ENG=$(echo $ENG|sed 's/var_c1Arr_=_new_Array//g'|sed 's/(//g'|sed 's/)//g'|sed 's/;//g'|sed 's/,/\ /g'|sed 's/\"//g')
		GER=$(echo $GER|sed 's/var_c2Arr_=_new_Array//g'|sed 's/(//g'|sed 's/)//g'|sed 's/;//g'|sed 's/,/\ /g'|sed 's/\"//g')
		ENG=( $ENG )
		GER=( $GER )
		echo E: $ENG
		echo G: $GER
		if [ ${#ENG[@]}==${#GER[@]} ]
		then
			for (( i=0; i<${#ENG[@]}; i++ )); do
				echo $i: ${ENG[$i]} \- ${GER[$i]}
			done
		else
			echo Array-Sizes are not equal!; echo E:${ENG}; echo G:${GER}
		fi
	else
                echo -e "Get the german translation of an english word"
                echo -e "${RED}usage:${BLUE} translate() <word>"
	fi
}

weather()
{
	[ $# -gt 0 ] && echo -e "Get weather-info"
	declare -a WEATHERARRAY 
	WEATHERARRAY=( `links -dump "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+60311&btnG=Search" | grep -A 5 -m 1 "Weather for" | grep -v "Add to "`) 
	echo ${WEATHERARRAY[@]} 
}

wiki()
{
	if [ "$#" -lt 1 ]; then
		echo -e "Search Wikipedia for a specific Word"
		echo -e "${RED}usage:${BLUE} wiki() <word>" && return;
	fi
	dig +short txt "${@}".wp.dg.cx | sed -e 's/" "//g' -e 's/^"//g' -e 's/"$//g' -e 's/ http:/\n\nhttp:/' | fmt -w $(tput cols);
}

webserverinfo()
{
	if [ $# -gt 0 ]
	then
		if [ $# -eq 2 ]
		then
			printf 'GET / HTTP/1.0\n\n' | nc -w 10 $1 80 | head -$2
		else
			printf 'HEAD / HTTP/1.0\n\n' | nc -w 10 $1 80
		fi
	else
		echo -e "Print informations about the running WebServer"
		echo -e "${RED}usage:${BLUE} webserverinfo() <url>" && return;
	fi
}



corename()
{ 
	if [ "$#" -lt 1 ]; then
		echo -e "Show Name of the Application that created the CoreDump-file"
		echo -e "Usage: corename() <file1> [<file2> <...>]" && return;
	fi
	for file ; do
		echo -n $file : ; gdb --core=$file --batch | head -1
	done 
}



# Begin gpg functions
encrypt ()
{
# Use ascii armor
gpg -ac --no-options "$1"
}

bencrypt ()
{
# No ascii armor
# Encrypt binary data. jpegs/gifs/vobs/etc.
gpg -c --no-options "$1"
}

decrypt ()
{
gpg --no-options "$1"
}

pe ()
{
# Passphrase encryption program
# Created by Dave Crouse 01-13-2006
# Reads input from text editor and encrypts to screen.
clear
echo "         Passphrase Encryption Program";
echo "--------------------------------------------------"; echo "";
which $EDITOR &>/dev/null
 if [ $? != "0" ];
     then
     echo "It appears that you do not have a text editor set in your .bashrc file.";
     echo "What editor would you like to use ? " ;
     read EDITOR ; echo "";
 fi
echo "Enter the name/comment for this message :"
read comment
$EDITOR passphraseencryption
gpg --armor --comment "$comment" --no-options --output
passphraseencryption.gpg --symmetric passphraseencryption
shred -u passphraseencryption ; clear
echo "Outputting passphrase encrypted message"; echo "" ; echo "" ;
cat passphraseencryption.gpg ; echo "" ; echo "" ;
shred -u passphraseencryption.gpg ;
read -p "Hit enter to exit" temp; clear
}

keys ()
{
# Opens up kgpg keymanager
kgpg -k
}

encryptfile ()
{
zenity --title="zcrypt: Select a file to encrypt" --file-selection > zcrypt
encryptthisfile=`cat zcrypt`;rm zcrypt
# Use ascii armor
#  --no-options (for NO gui usage)
gpg -acq --yes ${encryptthisfile}
zenity --info --title "File Encrypted" --text "$encryptthisfile has been encrypted"
}

decryptfile ()
{
zenity --title="zcrypt: Select a file to decrypt" --file-selection > zcrypt
decryptthisfile=`cat zcrypt`;rm zcrypt
# NOTE: This will OVERWRITE existing files with the same name !!!
gpg --yes -q ${decryptthisfile}
zenity --info --title "File Decrypted" --text "$encryptthisfile has been decrypted"
}

# Add a Key from Keyserver to APT-DB
addkey()
{
#gpg --keyserver subkeys.pgp.net --recv $1
gpg --keyserver wwwkeys.eu.pgp.net --recv $1
gpg --export --armor $1 | sudo apt-key add -
}


