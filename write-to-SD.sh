#if True, write the RasPiOS image to an SD card
WRITEIMG=$(find /home/$USER/Downloads/*raspios*lite*.img)
WRITESD=True
SDPATH=/dev/sdc

if [ $WRITESD = True ]; then echo "### Writing RasPiOS to SD card..." && sudo dd if=$WRITEIMG of=$SDPATH bs=4M oflag=dsync status=progress ; else echo "### Not Writing RasPiOS to SD card... Exiting Script" ; fi

