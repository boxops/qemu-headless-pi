DOWNLOADPATH=/home/$USER/Downloads/qemu-rpi-kernel
GITURL=https://github.com/dhruvvyas90/qemu-rpi-kernel

if [ -d $DOWNLOADPATH ]; then echo "### qemu-rpi-kernel folder exists"; else echo "### Downloading qemu-rpi-kernel git repository" && git clone $GITURL $DOWNLOADPATH; fi

DRIVEPATH=$(find /home/$USER/Downloads/*raspios*lite*.img)
DTBPATH=/home/$USER/Downloads/qemu-rpi-kernel/versatile-pb-buster-5.4.51.dtb
KERNELPATH=/home/$USER/Downloads/qemu-rpi-kernel/kernel-qemu-5.4.51-buster

qemu-system-arm \
-M versatilepb \
-cpu arm1176 \
-m 256 \
-drive "file=$DRIVEPATH,if=none,index=0,media=disk,format=raw,id=disk0" \
-device "virtio-blk-pci,drive=disk0,disable-modern=on,disable-legacy=off" \
-net "user,hostfwd=tcp::5022-:22" \
-dtb $DTBPATH \
-kernel $KERNELPATH \
-nographic \
-append "console=ttyAMA0 root=/dev/vda2 panic=1 rootfstype=ext4 rw" \
-net nic,id=eth0 \
-no-reboot
