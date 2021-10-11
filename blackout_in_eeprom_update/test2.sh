#!/bin/bash

ssh_username='elt'
ssh_password='orbital'
target_ip_address='10.160.2.23'

loop_count=1

if [ $# -ge 1 ]; then
    loop_count=$1
fi

echo "Loop $loop_count times."

count=1

while [ $count -le $loop_count ]
do
    echo "======== $count ========="

    while [ 1 ];
    do
        sshpass -p $ssh_password ssh -l $ssh_username $target_ip_address ls
        if [ $? -eq 0 ]; then
            break 
        fi
	sleep 2
    done

    pieeprom_file='~/eeprom/pieeprom-ogi-a.bin'
    if [ $(( $count & 0x01 )) == 0 ] ; then
        pieeprom_file='~/eeprom/pieeprom-ogi-b.bin'    
    fi
    echo "EEPROM $pieeprom_file ."

    sshpass -p $ssh_password ssh -l $ssh_username $target_ip_address "sudo rpi-eeprom-config"
    sshpass -p $ssh_password ssh -l $ssh_username $target_ip_address "sudo rpi-eeprom-update -d -f  $pieeprom_file"
    sshpass -p $ssh_password ssh -l $ssh_username $target_ip_address "sudo reboot"

    /usr/local/Cellar/python@3.8/3.8.11/bin/python3 test2.py
    /usr/local/Cellar/python@3.8/3.8.11/bin/python3 p105.py on
    
    let count=$count+1
done
