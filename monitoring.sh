#!/bin/bash
arc=$(uname -a)
cpup=$(grep -c ^processor /proc/cpuinfo)
cpuv=$(cat /proc/cpuinfo | grep processor | wc -l)
memu=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }')
disku=$(df --si -BMB --total | grep -E "^total" | awk '{printf "%d/%dGb (%s)\n", $3,$2,$5}')
cpuu=$(top -bn1 | grep '^%Cpu' | grep -oP "(\d){1,3}\.\d(?= id)" | awk '{printf("%.2f%%", 100 - $1)}')
lstboot=$(uptime -s)
lvm=$(lsblk | grep "lvm" | wc -l)
lvmu=$(if [ $lvm -eq 0 ]; then echo no; else echo yes; fi)
tcpc=$(netstat -ant | grep ESTABLISHED | wc -l)
usr_lg=$(who | sort -uk1,1 | wc -l)
netw_ip=$(hostname -I)
netw_mac=$(cat /sys/class/net/enp0s3/address)
sucmd=$(cat /var/log/sudo/sudo.log | wc -l | awk '{printf "%d", $1 / 2}')

wall "#Architecture : $arc
    #CPU physical : $cpup
	#vCPU : $cpuv
	#Memory Usage : $memu
	#Disk Usage : $disku
	#CPU Usage : $cpuu
	#Last Boot : $lstboot
	#LVM use : $lvmu
	#Connexions TCP : $tcpc
	#User Log : $usr_lg
	#Network : $netw_ip ($netw_mac)
	#Sudo : $sucmd cmd"	
