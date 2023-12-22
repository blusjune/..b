#!/bin/bash
# 20231222_130906
# .bdx.0100.y.textproc.filename.convert_whitespace_to_underscore.sh


_progname=".bdx.0100.y.textproc.filename.convert_whitespace_to_underscore.sh";
_fn_radix="$( echo $_progname | awk -F'.' '{ print $(NF-1) }' )";
_ts="date +%Y%m%d_%H%M%S";
_tmp_file_p1="/tmp/.tmp.bdx.$($_ts).${_fn_radix}.p1.txt"; # phase 1
_tmp_file_p2="/tmp/.tmp.bdx.$($_ts).${_fn_radix}.p2.txt"; # phase 2
echo $_tmp_file_p1;
echo $_tmp_file_p2;

_type_enter_to_go_further()
{
	read -p "
### type enter to go further ";
}

_cmd_4_flist_default="ls -1";
read -p "### ASK: command to get list of files to process [$_cmd_4_flist_default] " _cmd_4_flist;
if [ "X${_cmd_4_flist}" = "X" ]; then
	_cmd_4_flist="$_cmd_4_flist_default";
fi

$_cmd_4_flist > $_tmp_file_p1;
cat $_tmp_file_p1;
read -p "### ASK: Is this what you wanted? [Y|n] " _answer;
if [ "X$_answer" != "Xy" ]; then
	echo "### INF: terminate this program.";
	exit 0;
fi
#cat $_tmp_file_p1 | awk 'BEGIN{RS="\n"; FS="\n"} { SWORD=$1; DWORD=gsub(/ /,"_",$1); print "mv %s %s", SWORD, DWORD; }';
#cat $_tmp_file_p1 | awk 'BEGIN{RS="\n"; FS="\n"} { SWORD=$1; DWORD=gsub(/ /,"_",$1); print "mv ", SWORD, DWORD; }';
cat $_tmp_file_p1 | awk 'BEGIN{RS="\n"; FS="\n"} { SWORD=$1; DWORD=$1; gsub(/ /,"_",DWORD); if (SWORD != DWORD) { print "mv \"" SWORD "\" " DWORD }}' > $_tmp_file_p2;
cat $_tmp_file_p2 ;
read -p "### ASK: Do you want to execute this? [Y|n] " _answer;
if [ "X$_answer" = "Xy" ]; then
	cat $_tmp_file_p2 | sh
fi
exit 0;


