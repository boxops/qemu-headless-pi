#!/usr/bin/env bash

################## Systemd-nspawn Container Setup Script for RasPiOS Headless Configuration ##################

#pi-config.txt file is required to run this script
#the script will attempt to write the configured image to an SD card if 'WRITESD=True' at the end of the script
#if 'WRITESD=True', then ensure to format your SD card before running this script to avoid failures

#check if pi-config.txt file exist, exit script otherwise
CONFIGPATH=pi-config.txt
if [ -f "$CONFIGPATH" ]; then
  echo "### Config file is present."
else
  echo "### Config file is NOT present. Exiting Script"; exit 1; fi

#update system
echo "### Updating System and Checking for required packages... "
sudo apt update -y

#check if packages are installed, install the required packages if not
REQPKG="qemu qemu-system-arm qemu-user-static util-linux systemd-container"
for item in $REQPKG;
do
  PKGCHECK=$(dpkg-query -W --showformat='${Status}\n' $item | grep "install ok installed")
  if [ "$PKGCHECK" = "install ok installed" ]; then
    echo "### $item is installed."
  else
    echo "### Installing $item" && sudo apt-get install $item -y
  fi
done

#check if a RasPiOS Lite zip file exist, download the latest version if not
ZIPPATH="$(pwd)/raspios_lite_armhf_latest"
DOWNLOADPATH=$(pwd)
RASPILATEST=https://downloads.raspberrypi.org/raspios_lite_armhf_latest
if [ -f $ZIPPATH ]; then
  echo "### $ZIPPATH exist."
else
  wget -P $DOWNLOADPATH $RASPILATEST
fi

#check if a RasPiOS Lite image exist, inflate a downloaded file if not
IMGPATH="$(pwd)/*raspios*lite*.img"
if [ -f $IMGPATH ]; then
  echo "### $IMGPATH exist."
else
  unzip $ZIPPATH -d $DOWNLOADPATH
fi
#example inflated image: 2020-05-27-raspios-buster-lite-armhf.img

#make the partition available
#echo ", +" | sfdisk -N 2 /home/$USER/Downloads/*raspios*lite*.img
echo ", +" | sfdisk -N 2 $IMGPATH

#attach the image to a loop device, shows path e.g. /dev/loop13
#sudo losetup -fP --show /home/$USER/Downloads/*raspios*lite*.img
LOPATH=$(sudo losetup -fP --show $IMGPATH)

#tell the kernel about partitions
#sudo partx -a /dev/loop13
sudo partx -a $LOPATH

#(partx: /dev/loop13: error adding partitions 1-2) - error if partitions already exist
#show partitions: lsblk /dev/loop13

#extend the disk image size
#sudo qemu-img resize /home/$USER/Downloads/*raspios*lite*.img 2G
sudo qemu-img resize $IMGPATH 2G

LOPART1="${LOPATH}p1"
LOPART2="${LOPATH}p2"

#check and grow the ext4 filesystem
#sudo e2fsck -f /dev/loop13p2
sudo e2fsck -f $LOPART2

#sudo resize2fs /dev/loop13p2
sudo resize2fs $LOPART2

PIROOT=/tmp/rpi
PIBOOT="${PIROOT}/boot"

#create a mount directory
#sudo mkdir -p /tmp/rpi
sudo mkdir -p $PIROOT

#mount root and boot
#sudo mount /dev/loop13p2 /tmp/rpi
sudo mount $LOPART2 $PIROOT

#sudo mount /dev/loop13p1 /tmp/rpi/boot
sudo mount $LOPART1 $PIBOOT

#check that space is extended
#df -h /tmp/rpi
df -h $PIROOT

################## Launch container to configure RasPiOS ##################

#start the systemd-nspawn container and pass commands to it from pi-config.txt file, default user is root (root@path:~#)
#cat /home/$USER/Documents/FYP/Project-practice/pi-config.txt | \
# sudo systemd-nspawn \
# -q \
# --bind /usr/bin/qemu-arm-static \
# -D /tmp/rpi \
# --pipe /bin/bash
cat $CONFIGPATH | sudo systemd-nspawn -q --bind /usr/bin/qemu-arm-static -D $PIROOT --pipe /bin/bash

################## Clean up and Write image to an SD card ##################

#unmount the directory and clean up the loopback device
#sudo umount /tmp/rpi/boot
sudo umount $PIBOOT

#sudo umount /tmp/rpi
sudo umount $PIROOT

#sudo rm -r /tmp/rpi
sudo rm -r $PIROOT

#sudo losetup -d /dev/loop13
sudo losetup -d $LOPATH

echo "### Configuration Done, Exiting Script ###"

#Keep in mind that resizing the RasPiOS will be required after writing the image to an SD card to make the Pi usable
#To resize the OS on a Raspberry Pi:
#sudo raspi-config
#Select: Advanced Options > Expand Filesystem, then Finish and Reboot
