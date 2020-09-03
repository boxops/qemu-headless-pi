# qemu-headless-pi
Configure a RasPiOS image in a systemd-nspawn jail and test configuration using qemu-system-arm before writing the configured image to an SD card. (in development)

Step 1. Customise your 'pi-config.txt' for your needs by changing IP address and route to your needs.

Step 2. Start by customising 'headless-pi-setup.sh' file by rewriting variables based on the path to your files. 

Step 3. Run 'headless-pi-setup.sh' without an argument: ./headless-pi-setup.sh

Step 4. Test the configured file by customising and running 'qemu-system-arm.sh' without an argument: ./qemu-system-arm.sh

The script will boot the configured RasPiOS in a qemu emulator. 

Default credentials:
username: pi 
password: raspberry
