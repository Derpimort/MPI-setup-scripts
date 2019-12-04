#!/bin/bash
slaveIP="$(hostname -I)"
slaveMAC="$(cat /sys/class/net/eth0/address)"
slaveLines="slave"
slaveLines+="$(sed -n '$=' ./hosts.txt)"
masterIP="192.168.1.1"
mpiuserName="mpiuser"
mpiuserPass="123456"
sed -i "/127.0.1.1/a $masterIP\tmaster\n$slaveIP\t$slaveLines" /etc/hosts
sed -i '/^127.0.1.1/s/^/#/' /etc/hosts
echo -e  "$slaveIP\t$slaveLines">>./hosts.txt
echo -e  "$slaveMAC\t$slaveLines">>./MACs.txt
adduser --disabled-password --gecos ""  $mpiuserName
echo "$mpiuserName:$mpiuserPass" | sudo chpasswd
hostnamectl set-hostname $slaveLines
