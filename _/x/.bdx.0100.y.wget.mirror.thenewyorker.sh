#!/bin/bash
# 20231116_214030
# .bdx.0100.y.wget.mirror.thenewyorker.sh




_basic_options=" --mirror --page-requisites --convert-links --adjust-extension --span-hosts ";
#	--mirror (-m)
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




wget $_basic_options -t 1 -e robots=off -U $_user_agent $_target_website
#wget $_basic_options -t 1 -e robots=off -U $_user_agent -D $_domain_list $_target_website




###
### History: not satisfactory options
###
#wget -mpHkKEb -t 1 -e robots=off -U $_user_agent -D $_domain_list $_target_website
#wget -mpkKEb -t 1 -e robots=off -U $_user_agent -D $_domain_list $_target_website
#wget -mpHkKEb -t 1 -e robots=off -U $_user_agent $_target_website
#wget -mpHkKEb -t 1 -e robots=off -U "Brave/114.1.52.126 Google Chrome/114.0.5735.134 Internet Explorer/11.00.19041.1 Microsoft Edge/114.0.1823.51" http://www.newyorker.com/




