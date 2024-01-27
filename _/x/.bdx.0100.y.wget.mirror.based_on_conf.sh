#!/bin/bash
# 20231119_014147
# .bdx.0100.y.wget.mirror.based_on_conf.sh




_ts="date +%Y%m%d_%H%M%S";
_bdx_conf_file=".bdx_conf.wget.mirror.txt";




if [ ! -f $_bdx_conf_file ]; then
	cat > $_bdx_conf_file << EOF_CONF
# bdx conf file for .bdx.0100.y.wget.mirror.based_on_conf.sh
# $($_ts)
_target_website="http://www.newyorker.com/";
_domain_list="newyorker.com,www.wnyc.org";
_base_url="http://localhost/mirror/newyorker/";
_user_agent="Brave/114.1.52.126 Google Chrome/114.0.5735.134 Internet Explorer/11.00.19041.1 Microsoft Edge/114.0.1823.51";
EOF_CONF
fi
echo "#________________________________________________________________";
cat $_bdx_conf_file;
echo "#________________________________________________________________";




_basic_options=" --mirror --background --page-requisites --convert-links --adjust-extension --span-hosts ";
#_basic_options=" --mirror --background --page-requisites --convert-links --adjust-extension --span-hosts -w 1 --random-wait ";
#_basic_options=" --mirror --background --page-requisites --convert-links --adjust-extension --span-hosts -w 1 --random-wait -F -B ${_base_url} ";
#	--mirror (-m)
#	--background (-b)
#	--page-requisites (-p)
#	--convert-links (-k)
#	--adjust-extension (-E)
#	--span-hosts (-H)
#	--no-parent (-np)
#	--backup-converted (-K)
#	-w 1
#	--force-html (-F)
#	--base=_base_url (-B _base_url)
#	--random-wait
#	--D domain-list
#	-U _user_agent




### MAIN ###
read -p "### ASK:  Do you want to start with this '$_bdx_conf_file' ? [Y|n] " _answer;
if [ "X$_answer" = "Xy" ]; then
	set -x;
	. $_bdx_conf_file;
	wget $_basic_options -t 1 -e robots=off -U "$_user_agent" -D $_domain_list $_target_website ;
	set +x;
fi




### _________________________________
### History: not satisfactory options
###
#wget -mpHkKEb -t 1 -e robots=off -U $_user_agent -D $_domain_list $_target_website
#wget -mpkKEb -t 1 -e robots=off -U $_user_agent -D $_domain_list $_target_website
#wget -mpHkKEb -t 1 -e robots=off -U $_user_agent $_target_website
#wget -mpHkKEb -t 1 -e robots=off -U "Brave/114.1.52.126 Google Chrome/114.0.5735.134 Internet Explorer/11.00.19041.1 Microsoft Edge/114.0.1823.51" http://www.newyorker.com/
