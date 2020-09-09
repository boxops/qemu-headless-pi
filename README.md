# qemu-headless-pi
Configure a RasPiOS image in a systemd-nspawn jail and test configuration using qemu-system-arm before writing the configured image to an SD card. (Code was tested on Ubuntu 20:04 LTS Operating System)

Step 1. Customise your 'pi-config.txt' by modifying interface IP addresses and static routes to your needs.

Ensure that files have execute permissions: sudo chmod 700 headless-pi-setup.sh qemu-system-arm.sh write-to-SD.sh

Step 2. Run 'headless-pi-setup.sh' without an argument: ./headless-pi-setup.sh

Step 3. Test the configured file by running 'qemu-system-arm.sh' without an argument: ./qemu-system-arm.sh

The 'qemu-system-arm.sh' script will boot the configured RasPiOS in a qemu emulator. 

Default RasPiOS credentials:

username: pi 

password: raspberry

Step 4. Run 'write-to-SD.sh' without an argument to write the modified RasPiOS image to an SD card: ./write-to-SD.sh

Don't forget to format your SD card before running the 'write-to-SD.sh' script. 

Once the script is done writing the image, remove the SD card and place it in a Raspberry Pi 4B

Connect the pi to your network using an Ethernet cable and power on the device

SSH into the Pi once it is booted up:

ssh pi@192.168.1.240

Use the default credentials to login

It is important to resize the filesystem after connecting to the Raspberry Pi for the first time!

To resize the OS on a Raspberry Pi:

sudo raspi-config

Select: Advanced Options > Expand Filesystem, then Finish and Reboot

Alternatively, resize the filesystem with commands:

sudo raspi-config nonint do_expand_rootfs

sudo shutdown -r now

All tools and repositories in this project are open source and free to use.
Enjoy and have fun.
