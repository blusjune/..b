#!/bin/bash
# 20230907_075118

if [ "X${_SLEEP_AFTER_DONE}" = "Xyes" ]; then
	echo "### system will be hibernated (because _SLEEP_AFTER_DONE is '$_SLEEP_AFTER_DONE')";
else
	echo "### system will not be hibernated (because _SLEEP_AFTER_DONE is '$_SLEEP_AFTER_DONE')";
fi
read -p "### Do you want to go further? [y|N] " _answer;
if [ "X$_answer" != "Xy" ]; then
	echo "### nothing happended -- exit 0";
	exit 0;
fi
sleep 3;

_ts="date +%Y%m%d_%H%M%S";
_tsnapshot=$($_ts);
set -x;
echo $_tsnapshot > .bdx.${_tsnapshot}.log;
_tgt_dir=$(pwd); # here
cd ~blusjune/..bxd;
echo "### $($_ts): bxd tar ball - start"  > .bdx.${_tsnapshot}.log;
./.bdx.0100.y.ddb.pkg.sh;
echo "### $($_ts): bxd file copy - start"  > .bdx.${_tsnapshot}.log;
(cd  ~/..bxd/.ddb.pkg.d/; 
	_src_file=$(ls -1 .ddb.pkg.*.tar.gz | tail -1);
	cp -p $_src_file $_tgt_dir;
)
echo "### $($_ts): all done"  > .bdx.${_tsnapshot}.log;
if [ "X${_SLEEP_AFTER_DONE}" = "Xyes" ]; then
	sudo systemctl hibernate;
fi
