#Ensure to format SD card before writing RasPiOS image

IMGPATH=$(readlink -f "$(find . -name "*raspios*lite*.img")")
WRITESD=True
SDPATH=/dev/sdc
#Find SD card path:
#lsblk | grep sdc

if [ $WRITESD = True ]; then
  echo "### Writing RasPiOS to SD card..."
  sudo dd if=$IMGPATH of=$SDPATH bs=4M oflag=dsync status=progress
else
  echo "### Not Writing RasPiOS to SD card... " ; fi

#unmount and power off SD card for safe removal
sudo udisksctl unmount -b "${SDPATH}1"
sudo udisksctl unmount -b "${SDPATH}2"
sudo udisksctl power-off -b $SDPATH

#Remove the SD card and place it in a Raspberry Pi 4B
#Connect the pi to your network using an Ethernet cable and power on
#SSH into the Pi once it is booted up:
#ssh pi@192.168.1.240
#username: pi
#password: raspberry

#It is important to resize the filesystem after connecting to the Raspberry Pi for the first time
#To resize the OS on a Raspberry Pi:

#sudo raspi-config nonint do_expand_rootfs
#sudo shutdown -r now

#or

#sudo raspi-config
#Select: Advanced Options > Expand Filesystem, then Finish and Reboot
