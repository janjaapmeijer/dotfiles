# 1. check flash drive with f3
https://fight-flash-fraud.readthedocs.io/en/stable/introduction.html#examples

	./f3write /media/<username>/<diskname>

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

# 3. Write image to SPI flash from USB OTG port
https://wiki.radxa.com/Rockpi4/dev/spi-install
https://wiki.radxa.com/Rockpi4/dev/usb-install#Install_image_to_eMMC_from_USB_OTG_port

on pi:
- boot pi in maskrom mode
	- power off
	- remove microSD card
	- remove NVME disk
	- plug in USB male A to A with Linux PC (upper USB3 port on Pi)
	- connect PIN23 and PIN25
	- power on

on linux pc:
- Install rkdeveloptool on linux pc
https://wiki.radxa.com/Rockpi4/install/rockchip-flash-tools

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

- reboot pi, remove pin 23 and 25 and connect microSD and NVME

# 5. flash nvme with armbian image
https://wiki.radxa.com/Rockpi4/install/NVME
https://wiki.omv-extras.org/doku.php?id=installing_omv5_armbian_buster
https://wiki.omv-extras.org/doku.php?id=omv6:armbian_bullseye_install

- flash armbian to microSD with etcher and insert in rockpi
- flash armbian to nvme
	wget https://dl.armbian.com/rockpi-4b/archive/Armbian_20.08.1_Rockpi-4b_buster_current_5.8.6.img.xz

	sudo dd if=Armbian_20.08.1_Rockpi-4b_buster_current_5.8.6.img.xz of=/dev/nvme0n1 bs=1M

	# blkid /dev/mmcblk1p1
	# sudo dd if=/dev/disk/by-partuuid/6c80eaa4-01 conv=sync,noerror bs=4M of=/dev/nvme0n1p1
	# sudo umount /dev/nvme0n1p1
	# sudo e2fsck -f /dev/nvme0n1p1
	# sudo resize2fs /dev/nvme0n1p1
	# sudo e2fsck -f /dev/nvme0n1p1

# 7. login first time and kernel upgrade

	username: root
	password: 1234

	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get dist-upgrade

# 10. Connect via SSH
https://medium.com/@ptofanelli/raspberry-pi-creating-a-home-media-server-767e169a6cb3

		# sudo raspi-config
		sudo armbian-config

		ssh-copy-id -i ~/.ssh/id_rsa.pub <username>@rockpi

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
		> Auto logout: 1 day
		> Web admin passwd

	> Disks and Storage

	> Plugins
	> install openmediavault-sharerootfs
	> install openmediavault-resetperms




# 11. Setup KeePassXC as a credential store

	- install secret-tool
	# https://command-not-found.com/secret-tool
	sudo apt-get update
	sudo apt-get install libsecret-tools

	- update to keepassxc version >2.7
	sudo add-apt-repository ppa:phoerious/keepassxc
	sudo apt-get update
	sudo apt install keepassxc

	- disable gnome-keyring
	# https://www.chucknemeth.com/linux/security/keyring/keepassxc-keyring#disable-gnome-keyring
	killall -q -u "$(whoami)" gnome-keyring-daemon

	echo "[Desktop Entry]" >> ~/.config/autostart/gnome-keyring-pkcs11.desktop
	echo "Hidden=true" >> ~/.config/autostart/gnome-keyring-pkcs11.desktop

	echo "[Desktop Entry]" >> ~/.config/autostart/gnome-keyring-secrets.desktop
	echo "Hidden=true" >> ~/.config/autostart/gnome-keyring-secrets.desktop

	echo "[Desktop Entry]" >> ~/.config/autostart/gnome-keyring-ssh.desktop
	echo "Hidden=true" >> ~/.config/autostart/gnome-keyring-ssh.desktop

	- enable Secret Service Integration in KeePassXC
	> Tools > Settings >https://command-not-found.com/secret-tool

	- integration with docker
	https://mvalvekens.be/blog/2022/docker-dbus-secrets.html#setting-up-keepassxc-as-a-credential-store

# 12 Password manager with remote access
https://www.digitalocean.com/community/tutorials/how-to-serve-a-keepass2-password-file-with-nginx-on-an-ubuntu-14-04-server
https://github.com/keepassxreboot/keepassxc-ci-docker

# 11. Docker Compose
https://github.com/aaaldo/docker-compose-omv5-armhf

# 12. Store docker passwords
https://fcivaner.medium.com/how-to-store-your-aws-cli-credentials-on-keepassxc-5429dee1656d
