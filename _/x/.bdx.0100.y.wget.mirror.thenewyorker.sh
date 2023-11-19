#!/bin/bash
# 20231116_214030
# .bdx.0100.y.wget.mirror.thenewyorker.sh




_ts="date +%Y%m%d_%H%M%S";




_basic_options=" --mirror --background --page-requisites --convert-links --adjust-extension --span-hosts ";
#	--mirror (-m)
#	--background (-b)
#	--page-requisites (-p)
#	--convert-links (-k)
#	--adjust-extension (-E)
#	--span-hosts (-H)
#	--no-parent (-np)
#	--backup-converted (-K)
#	--D domain-list

_user_agent="Brave/114.1.52.126 Google Chrome/114.0.5735.134 Internet Explorer/11.00.19041.1 Microsoft Edge/114.0.1823.51";
_target_website="http://www.newyorker.com/";
_domain_list="newyorker.com"; #_domain_list="www.newyorker.com,contest.newyorker.com,downloads.newyorker.com,media.newyorker.com,newyorker.com,store.newyorker.com,subscribe.newyorker.com,video.newyorker.com";




set -x;
wget $_basic_options -t 1 -e robots=off -U $_user_agent -D $_domain_list $_target_website ;
set +x;
#wget $_basic_options -t 1 -e robots=off -U $_user_agent $_target_website




### _________________________________
### History: not satisfactory options
###
#wget -mpHkKEb -t 1 -e robots=off -U $_user_agent -D $_domain_list $_target_website
#wget -mpkKEb -t 1 -e robots=off -U $_user_agent -D $_domain_list $_target_website
#wget -mpHkKEb -t 1 -e robots=off -U $_user_agent $_target_website
#wget -mpHkKEb -t 1 -e robots=off -U "Brave/114.1.52.126 Google Chrome/114.0.5735.134 Internet Explorer/11.00.19041.1 Microsoft Edge/114.0.1823.51" http://www.newyorker.com/




