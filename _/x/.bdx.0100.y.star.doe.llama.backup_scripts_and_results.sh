#!/bin/bash
# 20230912_224246




#set -x;
_ts="date +%Y%m%d_%H%M%S";
_tstamp="$($_ts)";

_src_d="llama-meta-cpu";
_tgt_tarball="${_src_d}.${_tstamp}.tar.gz";
_tmp_bdx_d=".tmp.bdx.d";
_tmp_star_d=".tmp.star.d";

_files_d=".files.d"; mkdir -p ${_files_d};
_tlog_root=".tlog.d"; mkdir -p ${_tlog_root};
_tlog_path="NULL";




if [ -d ${_src_d}/${_tmp_bdx_d} -a -d ${_src_d}/${_tmp_star_d} ]; then
	_tid="$(cd ${_src_d}/$_tmp_bdx_d; ls -1 .star.doe.log.*.txt | head -1 | awk -F'.' '{ print $5 }')";
	_tlog_tid="tlog.${_tid}";
	_tlog_path="${_tlog_root}/${_tlog_tid}";
	if [ -d $_tlog_path ]; then
		echo "### INF: $_tlog_path already exists -- nothing to do -- EXIT 0";
		exit 0;
	fi
	mkdir -p ${_tlog_path};
	read -p "### ASK: store the DoE conf and test result to ${_tlog_path} ? [Y|n] " _answer;
	if [ "X$_answer" != "Xn" ]; then
		cp -prL ${_src_d}/.star.doe.* ${_tlog_path};
		if [ -d ${_src_d}/${_tmp_bdx_d} ]; then
			mv ${_src_d}/${_tmp_bdx_d} ${_tlog_path};
		fi
		if [ -d ${_src_d}/${_tmp_star_d} ]; then
			mv ${_src_d}/${_tmp_star_d} ${_tlog_path};
		fi
	else
		echo "### INF: Nothing happened";
	fi
else
	echo "### INF: no test result files ($_tmp_bdx_d , $_tmp_star_d) to store";
fi




read -p "### ASK: make tar-ball for ${_src_d} ? [Y|n] " _answer;
if [ "X$_answer" != "Xn" ]; then
	### move away .env (large amount of data) to outside of the source directory ($_src_d)
	( cd $_src_d; 
	if [ -d .env ]; then
		mv .env ../.env.${_tstamp}; 
	fi
	)
	### make tar-ball
	echo "tar cf - $_src_d | gzip -c > ${_files_d}/${_tgt_tarball}";
	tar cf - $_src_d | gzip -c > ${_files_d}/${_tgt_tarball};
	### copy tar-ball to the $_tlog_path
	if [ "X$_tlog_path" != "XNULL" -a -d $_tlog_path ]; then
		echo "cp -pr ${_files_d}/${_tgt_tarball} $_tlog_path";
		cp -pr ${_files_d}/${_tgt_tarball} $_tlog_path;
	fi
else
	echo "### INF: Nothing happened";
fi




