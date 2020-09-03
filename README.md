# qemu-headless-pi
Configure a RasPiOS image in a systemd-nspawn jail and test configuration using qemu-system-arm before writing the configured image to an SD card. (Code was tested on Ubuntu 20:04 LTS Operating System)

Step 1. Customise your 'pi-config.txt' by modifying the interface IP address and static routes to your needs.

Step 2. Run 'headless-pi-setup.sh' without an argument: ./headless-pi-setup.sh

Step 3. Test the configured file by running 'qemu-system-arm.sh' without an argument: ./qemu-system-arm.sh

The 'qemu-system-arm.sh' script will boot the configured RasPiOS in a qemu emulator. 

Default RasPiOS credentials:

username: pi 

password: raspberry

Step 4. Run 'write-to-SD.sh' without an argument to write the modified RasPiOS image to an SD card: ./write-to-SD.sh

Don't forget to format your SD card before running the 'write-to-SD.sh' script. 


All tools and repositories in this project are open source and free to use.
Enjoy and have fun.
