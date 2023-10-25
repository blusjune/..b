#!/bin/bash
# .bdx.0100.y.rsync.bbxd.to_usbmem.sh # 20230929_224212
# .bdx.0100.y.rsync.bbxd.to_ssd_0t5_t5_oasis.sh # 20230912_220510


source /_b/x/.blib.rsync.sh;


_mnt_root="/mnt/media.blusjune";
_usbmem_oasis=".mnt.S02T0_oasis";		# S02T0_oasis		# previously ".ssd_0t5_t5_oasis";
_usbmem_blur=".mnt.S01T0_blur";			# S01T0_blur		# previously ".ssd_1t0_t7_blur";
_usbmem_pinkfloyd=".mnt.H05T0_pinkfloyd";	# H05T0_pinkfloyd
_usbmem_metallica=".mnt.H16T0_metallica";	# H16T0_metallica


function _rsync_from_cwd_to_usbmem()
{
#_mnt_root="/mnt/media.blusjune";
#_usbmem_tgt="$_usbmem_blur";
	if [ -d ${_mnt_root}/${_usbmem_tgt} ]; then
		echo "### ===================================================================================";
		echo "### ===================================================================================";
		echo "###";
		echo "### INF: rsync to  ${_mnt_root}/${_usbmem_tgt}";
		echo "###";
		echo "### ___________________________________________________________________________________";
		sleep 2;
		_list_to_rsync="..b ..bxd .bigfiles.d";
		_rsync_target_dir_root="${_mnt_root}/${_usbmem_tgt}/..__ROOT__";
		_rsync_opt="-v --delete";
		rsync_exec;
		#
		#_list_to_rsync=".config";
		#_rsync_target_dir_root="${_mnt_root}/${_usbmem_tgt}/..__ROOT__/home.blusjune.$(hostname)";
		#_rsync_opt="-v --delete";
		#rsync_exec;
	fi
}




### ..b
echo "### INF:  ..b update";
(cd  ..b;
	read -p "### ASK:  ..b/_BDX ? [y|N]" _answer;
	if [ "X$_answer" = "Xy" ]; then
		/_b/x/_BDX;
	fi
	git add -Av;
	git commit -avs;
	read -p "### ASK:  git push --all -u ? [y|N]" _answer;
	if [ "X$_answer" = "Xy" ]; then
		git push --all -u;
	fi
)


### mediawiki DB dump
(cd  /_b/w/x/mediawiki; /_b/x/_BDX;) 


### rsync to usbmem
_list_tgt="
$_usbmem_blur
$_usbmem_oasis
$_usbmem_pinkfloyd
$_usbmem_metallica
";
for _usbmem_tgt in $_list_tgt; do
	echo $_usbmem_tgt;
	_rsync_from_cwd_to_usbmem;
done


### sync
sync;




#_usbmem_tgt="$_usbmem_oasis";
#_rsync_from_cwd_to_usbmem;
#_usbmem_tgt="$_usbmem_blur";
#_rsync_from_cwd_to_usbmem;




