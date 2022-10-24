#! /bin/bash
sudo su
#mount disk
mkdir /mnt/data
mount -o discard,defaults /dev/sdb /mnt/data
