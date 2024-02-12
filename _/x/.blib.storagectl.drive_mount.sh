#!/bin/bash
# 20240211_144802


function _storagectl__mount_all_usb_storage_drives()
{
	# using udisksctl (which should be used after launching GUI desktop)
	echo "### _________________________________________________________________________";
	echo "### mount";
	echo "### -------------------------------------------------------------------------";
	lsblk -lf | awk '{ if (($1 ~ /sd[a-z]/) && ($4 ~ /^[SH][0-9][0-9]T[0-9]_/)) { print "udisksctl mount  -b /dev/"$1, "# ", $4 }}' | sh
}


function _storagectl__unmount_all_usb_storage_drives()
{
	echo "### _________________________________________________________________________";
	echo "### unmount";
	echo "### -------------------------------------------------------------------------";
	# using udisksctl (which should be used after launching GUI desktop)
	lsblk -lf | awk '{ if (($1 ~ /sd[a-z]/) && ($4 ~ /^[SH][0-9][0-9]T[0-9]_/)) { print "udisksctl unmount  -b /dev/"$1, "# ", $4 }}' | sh
}


function _storagectl__list_all_usb_storage_drives()
{
	echo "### _________________________________________________________________________";
	echo "### list";
	echo "### -------------------------------------------------------------------------";
	# using udisksctl (which should be used after launching GUI desktop)
	lsblk -lf | awk '{ if (($1 ~ /sd[a-z]/) && ($4 ~ /^[SH][0-9][0-9]T[0-9]_/)) { print $0 } }'
}
