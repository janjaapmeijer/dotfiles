# 1. check flash drive with f3
https://fight-flash-fraud.readthedocs.io/en/stable/introduction.html#examples

	./f3write /media/michel/5EBD-5C80/
	/Volumes
	
# 2. format and partion microSD and NVME "Linux root (ARM 64)"
## Format microSD

	sudo fdisk -l
	umount /dev/mmcblk0p1
	sudo wipefs -a /dev/mmcblk0p1
	sudo parted /dev/mmcblk0 --script -- mklabel gpt

	or sudo parted /dev/mmcblk0 --script -- mklabel msdos

	sudo parted /dev/mmcblk0 --script -- mkpart primary fat32 1MiB 100%
	sudo mkfs.vfat -F32 /dev/mmcblk0p1
	
## Format NVME
https://github.com/Lymkin/RockP_4_Home_Assistant_Build

	sudo fdisk -l
	umount /dev/nvme0n1
	sudo wipefs -a /dev/nvme0n1
	sudo gdisk -l /dev/nvme0n1
	sudo gdisk /dev/nvme0n1
	> L 8305 Linux ARM64
	> n 
	> w
	sudo mkfs -t ext4 /dev/nvme0n1p1
	sudo mount /dev/nvme0n1p1 /mnt

	or

	sudo fdisk /dev/nvme0n1 —> n, p, 1, default, default, y, w
	
# 3. etcher microSD and insert in rockpi

# 4. Write image to SPI flash from USB OTG port
https://wiki.radxa.com/Rockpi4/dev/spi-install

on pi:
- Install rkdeveloptool on linux pc
- boot pi in maskrom mode
- power off
- remove microSD card
- remove NVME disk
- plug in USB male A to A with Linux PC
- connect PIN23 and PIN25
- power on

on linux pc:

	lsusb
		Bus 003 Device 005: ID 2207:330c
	rkdeveloptool ld
		DevNo=1	Vid=0x2207,Pid=0x330c,LocationID=102	Maskrom

- download SPI loader .bin and u-boot and trust.img to linux pc:
https://dl.radxa.com/rockpi/images/loader/spi/

		sudo rkdeveloptool db ~Downloads/rk3399_loader_spinor_v1.15.114.bin
		sudo rkdeveloptool wl 0 ~/Downloads/rockpi4b-uboot-trust-spi_2017.09-2697-ge41695afe3_20201219.img
		sudo rkdeveloptool rd

- if Creating Comm Object failed!

		echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="2207", MODE="0666",GROUP="plugdev"' | sudo tee /etc/udev/rules.d/51-android.rules

		or

		echo -1 | sudo tee /sys/module/usbcore/parameters/autosuspend
	
- reboot pi and connect microSD and NVME

# 5. flash nvme with armbian image

https://wiki.omv-extras.org/doku.php?id=installing_omv5_armbian_buster

	wget https://dl.armbian.com/rockpi-4b/archive/Armbian_20.08.1_Rockpi-4b_buster_current_5.8.6.img.xz

	sudo dd if=Armbian_20.08.1_Rockpi-4b_buster_current_5.8.6.img.xz of=/dev/nvme0n1 bs=1M

or

	blkid /dev/mmcblk1p1
	sudo dd if=/dev/disk/by-partuuid/6c80eaa4-01 conv=sync,noerror bs=4M of=/dev/nvme0n1p1
	sudo umount /dev/nvme0n1p1
	sudo e2fsck -f /dev/nvme0n1p1
	sudo resize2fs /dev/nvme0n1p1
	sudo e2fsck -f /dev/nvme0n1p1

# 6. shutdown pi, (remove connection pins 23 and 25) and remove SDcard

# 7. kernel upgrade

	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get dist-upgrade

# 8. Install Open Media Vault and Docker
https://openmediavault.readthedocs.io/en/latest/installation/on_debian.html

	sudo armbian-config
	>	Software
	>	Softy
		> OMV
		> Docker
	>	Install

# 9. Configure OMV
https://www.howtoforge.com/tutorial/install-open-media-vault-nas/

	http://<IP or hostname>

	username: admin
	password: openmediavault

	> General Settings
		> Port: 8085
		> Web admin passwd

	> Disks and Storage

	> Plugins
	> install openmediavault-sharerootfs

# 10. Connect via SSH
https://medium.com/@ptofanelli/raspberry-pi-creating-a-home-media-server-767e169a6cb3

	# sudo raspi-config
	sudo armbian-config


# 11. Docker Compose
https://github.com/aaaldo/docker-compose-omv5-armhf
