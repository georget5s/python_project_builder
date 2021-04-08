#!/bin/bash

hostname=$1
ip=$2

echo "Setting hostname to [$hostname] and ip address to [$ip], continue [y/n]"
read continue

if [[ $continue != "y" ]]; then
        echo "Exiting, no action taken..."
fi
echo "Rename host..."
echo "$1" > /etc/hostname


echo "Stop network..."
sudo systemctl stop NetworkManager.service


echo "Readdress server..."

rip='10\.0\.2\.200'
nip=`echo "$ip" | sed 's/\\./\\\./g'`
cat << __EOD__ | sed "s/$rip/$nip/g" > /etc/sysconfig/network-scripts/ifcfg-enp0s3
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="dhcp"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="enp0s3"
UUID="e69c471d-f596-4690-811c-a11737125b70"
DEVICE="enp0s3"
ONBOOT="yes"
IPV6_PRIVACY="no"
PREFIX="24"
IPADDR="10.0.2.200"
GATEWAY="10.0.2.2"
__EOD__

echo "Restart network..."
sudo systemctl restart NetworkManager.service

