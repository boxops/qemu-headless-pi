# qemu-headless-pi
Configure a RasPiOS image in a systemd-nspawn jail and test configuration using qemu-system-arm before writing the configured image to an SD card. 

Step 1. Customise your 'pi-config.txt' by modifying the interface IP address and static routes to your needs.

Step 2. Run 'headless-pi-setup.sh' without an argument: ./headless-pi-setup.sh

Step 3. Test the configured file by running 'qemu-system-arm.sh' without an argument: ./qemu-system-arm.sh

Step 4. (Optional) To write the modified RasPiOS image to an SD card, modify 'WRITESD=False' variable to 'WRITESD=True' in the end of the 'headless-pi-setup.sh' script, and run the script again.

The test script will boot the configured RasPiOS in a qemu emulator. 

Default RasPiOS credentials:

username: pi 

password: raspberry

All tools and repositories in this project are open source and free to use.
Enjoy and have fun.
