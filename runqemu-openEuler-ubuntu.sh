sudo qemu-system-x86_64 \
	-smp 2 \
	-m 1024M \
	-kernel ./kernel_memcg/arch/x86_64/boot/bzImage \
	-append "console=ttyS0 root=/dev/sda debug earlyprintk=serial slub_debug=QUZ"\
	-drive file=./ubuntu-openEuler/bionic.img,format=raw \
	-nographic \
