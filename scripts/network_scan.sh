#!/bin/bash
echo "network_scan.sh, asking for sudo permissions..."
sudo echo "sudo granted. Scanning..."
while true; do 
    sudo arp-scan --interface=wlan0 --localnet | grep : | grep 192.168.1;
    echo " ";
done
