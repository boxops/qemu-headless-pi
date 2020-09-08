DOWNLOADPATH="$(pwd)/qemu-rpi-kernel"
GITURL=https://github.com/dhruvvyas90/qemu-rpi-kernel

if [ -d $DOWNLOADPATH ]; then echo "### qemu-rpi-kernel folder exists"; else echo "### Downloading qemu-rpi-kernel git repository" && git clone $GITURL $DOWNLOADPATH; fi

DRIVEPATH=$(readlink -f "$(find . -name "*raspios*lite*.img")")
DTBPATH=$(readlink -f "$(find qemu-rpi-kernel -name "versatile-pb-buster-5.4.51.dtb")")
KERNELPATH=$(readlink -f "$(find qemu-rpi-kernel -name "kernel-qemu-5.4.51-buster")")

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
