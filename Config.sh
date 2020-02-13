#!/bin/bash
slaveIP="$(hostname -I)"
slaveMAC="$(cat /sys/class/net/eth0/address)"
slaveLines="slave"
slaveNum=""
slaveNum+="$(sed -n '$=' ./hosts.txt)"
slaveLines+="$slaveNum"
masterIP="192.168.1.1"
slaveIP="192.168.1."
mpiuserName="mpiuser"
mpiuserPass="123456"
sed -i "/127.0.1.1/a $masterIP\tmaster\n$slaveIP\t$slaveLines" /etc/hosts
sed -i '/^127.0.1.1/s/^/#/' /etc/hosts
echo -e  "$slaveIP\t$slaveLines">>./hosts.txt
echo -e  "$slaveMAC\t$slaveLines">>./MACs.txt
adduser --disabled-password --gecos ""  $mpiuserName
echo "$mpiuserName:$mpiuserPass" | sudo chpasswd
hostnamectl set-hostname $slaveLines
echo "  ethernets:
      eno1:
          addresses: [$slaveIP$slaveNum/24]
          gateway4: 192.168.1.1
          dhcp4: false
          nameservers:
              addresses: [8.8.8.8,8.8.4.4]">>/etc/netplan/$FILE_NAME_HERE
