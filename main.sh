#!/usr/bin/bash
#
# Name: archpi_imager.sh
# Description: small script to flash an Arch Linux image to an SD card.
# Contacto: github.com/robbertpaulsen

clear
read -p "Plase input the SDCard device id (/dev/sdX) drive : " SD
echo
echo
echo "Beginning Card wiping and formatting"
sleep 2
echo
echo
fdisk $SD << FDSK_CMDS
o
n
p
1
+200
Y
t
c
n
p
2
w
FDSK_CMDS

echo
echo
echo "Done, beginning to mount Image"
echo
echo
mkfs.vfat $SDp1
mkdir -p /mnt/boot
mount /mnt/boot
mkfs.ext4 $SDp2
mkdir -p /mnt/root
mount /mnt/root
sleep 2
wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz &&
bsdtar -xpf http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz -C /mnt/root &&
sync &&
mv /mnt/root/boot/* /mnt/boot &&
sleep 2
clear
echo
echo
sed -i 's/$SD/$SDp1/g' /mnt/root/etc/fstab