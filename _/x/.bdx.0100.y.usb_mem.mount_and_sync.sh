#!/bin/bash
#.bdx.0100.y.usb_mem.mount_and_sync.sh
#20230823_233800

_ddb_pkg_d=".ddb.pkg.d";
_usb_mem_devname="U2_USBMEM64GB";

if [ "X$( mount | grep $_usb_mem_devname | wc -l )" = "X0" ]; then
	_mount_dir="/mnt/usb_mem/${_usb_mem_devname}";
	sudo mkdir -p $_mount_dir;
	echo "____________";
	lsblk | grep -v 'loop'
	echo "____________";
	read -p ">>> usb dev node (/dev/sda1): " _usb_dev_node;
	echo "### mount $_usb_dev_node $_mount_dir";
	sudo mount $_usb_dev_node $_mount_dir;
else
	_usb_dev_node="$( mount | grep ${_usb_mem_devname} | awk '{ print $1 }' )";
	_mount_dir="$( mount | grep ${_usb_mem_devname} | awk '{ print $3 }' )";
	echo "### $_usb_dev_node is already mounted on $_mount_dir";
	#_mount_dir_automatic="/media/blusjune/U2_USBMEM64GB";
fi
_target_dir="${_mount_dir}/${_ddb_pkg_d}";
_source_dir="/home/blusjune/..b/${_ddb_pkg_d}";
sudo mkdir -p $_target_dir;

cd $_source_dir;
_ddb_pkg_file=$( ls -1 .ddb.pkg._.*.tar.gz | tail -1 );
echo -n "### cp ${_ddb_pkg_file} ${_target_dir} ... ";
sudo cp ${_ddb_pkg_file} ${_target_dir};
echo "done";

(cd $_target_dir; ls -alF;)

read -p ">>> do you want to umount $_mount_dir ? [Y|n] " _answer;
if [ "X$_answer" != "Xn" ]; then
	sudo umount $_mount_dir;
	echo "### $_mount_dir is unmounted";
else
	echo "### you declined. nothing happened.";
fi
