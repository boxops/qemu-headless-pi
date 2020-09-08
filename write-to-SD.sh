#Ensure to format SD card before writing RasPiOS image

IMGPATH=$(readlink -f "$(find . -name "*raspios*lite*.img")")
WRITESD=True
SDPATH=/dev/sdc
#Find SD card path:
#lsblk | grep sdc

if [ $WRITESD = True ]; then echo "### Writing RasPiOS to SD card..." && sudo dd if=$IMGPATH of=$SDPATH bs=4M oflag=dsync status=progress ; else echo "### Not Writing RasPiOS to SD card... " ; fi

#unmount and power off SD card for safe removal
sudo udisksctl unmount -b "${SDPATH}1"
sudo udisksctl unmount -b "${SDPATH}2"
sudo udisksctl power-off -b $SDPATH
