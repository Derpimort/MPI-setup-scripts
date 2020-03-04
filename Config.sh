#!/bin/bash
slaveIP="$(hostname -I)"
netInterface="$1"
slaveMAC="$(cat /sys/class/net/$netInterface/address)"
slaveLines="slave$2-"
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

#Static Ips

##For Ubuntu 18.04
echo -e "  ethernets:
      eno1:
          addresses: [$slaveIP$slaveNum/24]
          gateway4: 192.168.1.1
          dhcp4: false
          nameservers:
              addresses: [8.8.8.8,8.8.4.4]">>/etc/netplan/01-network-manager-all.yaml
netplan apply

##For Ubuntu 16.04
echo "auto $netInterface
iface $netInterface inet static 
  address $slaveIP$slaveNum
  netmask 255.255.255.0
  gateway 192.168.1.1
  dns-nameservers 8.8.4.4
  dns-nameservers 8.8.8.8" >> /etc/network/interfaces
/etc/init.d/network restart
systemctl restart network

#If you want nfs configured
mkdir /home/$mpiuserName/storage
echo -e "master:/home/$mpiuserName/storage /home/$mpiuserName/storage nfs timeo=30 0 0" >> /etc/fstab
mount -a
