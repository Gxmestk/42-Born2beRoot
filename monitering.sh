#!/bin/bash
ARCH1=$(hostnamectl | grep "Operating System" | cut -d ':' -f 2 )
ARCH2=$(hostnamectl | grep "Kernel" | cut -d ':' -f 2)
ARCH3=$(hostnamectl | grep "Architecture" | cut -d ':' -f 2)
ARCH4=$(lscpu | grep "Model name" |cut -d ':' -f 2 | tr -d ' ')
ARCH="$ARCH1$ARCH2$ARCH3"

pCPU=$(cat /proc/cpuinfo | grep processor | wc -l)
vCPU="$pCPU"

MemUu=$(free -h | grep Mem | awk '{print $3}')
MemUt=$(free -h | grep Mem | awk '{print $2}')
MemUp=$(free -k | grep Mem | awk '{printf("%.2f%%"), $3 / $2 * 100}')
MemU="$MemUu / $MemUt ($MemUp)"

DiskUu=$(df -h --total | grep total | awk '{print $3}')
DiskUt=$(df -h --total | grep total | awk '{print $2}')
DiskUp=$(df -k --total | grep total | awk '{print $5}')
DiskU="$DiskUu / $DiskUt ($DiskUp)"

CPUl=$(mpstat | grep all | awk '{printf("%.2f%%"), 100 - $13}')

LB=$(who -b | awk '{print($3"\t"$4)}')

if [[ $(lsblk | grep lvm | wc -l) -eq 0 ]]
then
        LVMu="no"
else
        LVMu="yes"
fi

TCPc1=$(netstat -an | grep ESTABLISHED |  wc -l)
TCPc="$TCPc1 ESTABLISHED"

Ulog=$(who | cut -d " " -f 1 | uniq | wc -l)

Net1=$(hostname -I | awk '{print $1}')
Mac=$(ip link show | grep link/ether | awk '{print $2}')
Net="IP $Net1 ($Mac)"

Sudo1=$(grep 'sudo:' /var/log/auth.log | wc -l)
Sudo="$Sudo1 cmd"

echo "#Architecture: $ARCH
#CPU physical: $pCPU
#vCPU: $vCPU
#Memory Usage: $MemU
#Disk Usage: $DiskU
#CPU load: $CPUl
#Last boot: $LB
#LVM use: $LVMu
#Connections TCP : $TCPc
#User log: $Ulog
#Network: $Net
#Sudo : $Sudo" | wall