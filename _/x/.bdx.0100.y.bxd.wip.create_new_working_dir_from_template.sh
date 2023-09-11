# 20230905_233442
# .bdx.0100.y.bxd.wip.create_new_working_dir_from_template.sh
# 
# ### wd: working directory
# cd /_b/w/2023/_BMW.20230904.ai_llm_hugging_face.d;   ### current _BMW directory
# cp -pr .files.d/.template.wd /_b/s/bxd/wip/huggingface/wd.huggingface.20230909_235813;
# ln -s /_b/s/bxd/wip/huggingface/wd.huggingface.20230909_235813 wd.huggingface;

_ts="date +%Y%m%d_%H%M%S";
_files_dir=".files.d";
_template_dir=".template.wd";
read -p "_wd_corename [huggingface]: " _wd_corename;   ### working directory core name
if [ "X$_wd_corename" = "X" ]; then
	_wd_corename="corename"; #_wd_corename="huggingface";
fi
_wip_dir="/_b/s/bxd/wip/${_wd_corename}";
_new_wd_instance="wd.${_wd_corename}.$($_ts)";
_wd_symlink_name="wd.${_wd_corename}";
if [ ! -d ${_wip_dir} ]; then
	echo "### ERROR: no such directory: ${_wip_dir} -- EXIT 18";
	exit 18;
fi

set -x;
cp -pr ${_files_dir}/${_template_dir} ${_wip_dir}/${_new_wd_instance};
( cd ${_wip_dir}/${_new_wd_instance};
	touch ..__${_new_wd_instance}__;
)
rm -f $_wd_symlink_name;
ln -s ${_wip_dir}/${_new_wd_instance} $_wd_symlink_name;

