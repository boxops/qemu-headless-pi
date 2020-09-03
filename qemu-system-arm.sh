DRIVEPATH=/home/deadmanhide/Downloads/2020-05-27-raspios-buster-lite-armhf.img
DTBPATH=/home/deadmanhide/Documents/FYP/Project-practice/qemu-rpi-kernel/versatile-pb-buster-5.4.51.dtb
KERNELPATH=/home/deadmanhide/Documents/FYP/Project-practice/qemu-rpi-kernel/kernel-qemu-5.4.51-buster

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

