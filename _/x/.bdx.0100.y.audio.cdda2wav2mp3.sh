#!/bin/bash
# .bdx.0100.y.audio.cdda2wav2mp3.sh
# 20231002_110918


_ts="date +%Y%m%d_%H%M%S";

function _print_help()
{
	echo "
======================================================
### INF:  Prerequisites:
	cdparanoia -sQ; cdparanoia -A; cdparanoia -BX;
	lame;
	mp3tag;
";
	echo "
### INF:  Basic assumptions of directory hierarchy and naming:
	directory format:
		~/Audio/AudioBook/\$_author/\$_book/.disc-\$( printf '%02d' \$_track_number )/
	example:
		~/Audio/AudioBook/Jared_Diamond/Guns_Germs_and_Steel/.disc-01/
";
	echo "
### INF:  we assume that you already completed to extract CDDA wav files like the following:
	aerosmith:~$  pwd
	/home/blusjune

	aerosmith:~$ cd Audio/AudioBook/
	aerosmith:~/Audio/AudioBook$ mkdir -p Jared_Diamond/Guns_Germs_and_Steel
	aerosmith:~/Audio/AudioBook$ cd Jared_Diamond/Guns_Germs_and_Steel/

	aerosmith:~/Audio/AudioBook/Jared_Diamond/Guns_Germs_and_Steel$ mkdir -p .disc-01
	aerosmith:~/Audio/AudioBook/Jared_Diamond/Guns_Germs_and_Steel$ cd .disc-01
	aerosmith:~/Audio/AudioBook/Jared_Diamond/Guns_Germs_and_Steel/.disc-01$ cdparanoia -sQ; cdparanoia -A; cdparanoia -BX;

	aerosmith:~/Audio/AudioBook/Jared_Diamond/Guns_Germs_and_Steel/.disc-01$ cd ..
	aerosmith:~/Audio/AudioBook/Jared_Diamond/Guns_Germs_and_Steel$ ls -alF
	total 13
	drwxrwxrwx 1 blusjune blusjune  360 Oct  2 12:14 ./
	drwxrwxrwx 1 blusjune blusjune    0 Oct  2 01:55 ../
	lrwxrwxrwx 1 blusjune blusjune   34 Oct  2 11:28 .bdx.0100.y.audio.wav2mp3.sh -> /_b/x/.bdx.0100.y.audio.wav2mp3.sh*
	drwxrwxrwx 1 blusjune blusjune 4096 Oct  2 10:23 .disc-01/
	drwxrwxrwx 1 blusjune blusjune 4096 Oct  2 07:54 .disc-02/
	drwxrwxrwx 1 blusjune blusjune 4096 Oct  2 10:21 .disc-03/
";
	echo "### INF:  Let's get started
======================================================

";
}
_print_help;


echo "### ---------------------------------------------------------------------";
read -p "### ASK:  Exec phase-1? (create .disc-NN dirs and bdx.cdda.wav_gen) [n|Y] " _answer;
if [ "X$_answer" = "Xy" ]; then
	_k=0;
	_kn=1;
	_num_of_discs_default="20";
	_bdx_cdda_wav_gen=".bdx.0100.y.cdda.wav_gen.sh";
	read -p "_num_of_discs: [${_num_of_discs_default}] " _num_of_discs;
	if [ "X$_num_of_discs" = "X" ]; then _num_of_discs=$_num_of_discs_default; fi
	while [ $_k -lt $_num_of_discs ]; do
		_k=$( expr $_k + 1 );
		_kn=$( expr $_kn + 1 );
		_dir_name=".disc-$( printf '%02d' $_k )";
		_dir_name_next=".disc-$( printf '%02d' $_kn )";
		echo -n "### INF:  mkdir -p ${_dir_name};";
		mkdir -p $_dir_name;
		(cd $_dir_name;
			cat > $_bdx_cdda_wav_gen << EOF_BDX_CDDA_WAV_GEN
#!/bin/bash
# $($_ts)
_t1="\$($_ts)";
cdparanoia -sQ >& .cdda.tracklist.txt; cdparanoia -A; cat .cdda.tracklist.txt; cdparanoia -BX;
_t2="\$($_ts)";
echo "___________________________________________________________________";
echo "### INF:  \$_t1  --[cdda_wav_gen]-->  \$_t2"
EOF_BDX_CDDA_WAV_GEN
			if [ $_k -lt $_num_of_discs ]; then
				cat >> $_bdx_cdda_wav_gen << EOF_BDX_CDDA_WAV_GEN
echo "___________________________________________________________________";
echo "### INF:  Move to the next disc:  cd ../${_dir_name_next}"
EOF_BDX_CDDA_WAV_GEN
			else
				cat >> $_bdx_cdda_wav_gen << EOF_BDX_CDDA_WAV_GEN
echo "___________________________________________________________________";
echo "### INF:  Processing completed ( $_k of $_k discs )";
EOF_BDX_CDDA_WAV_GEN
			fi
			chmod 755 $_bdx_cdda_wav_gen;
			echo "### INF:  cat > ${_bdx_cdda_wav_gen} << EOF;";
		)
	done
	echo "### ---------------------------------------------------------------------";
	echo "### INF:  Please do .bdx (in .disc-NN dirs) to make wav files from CDDA";
fi


echo "

### ---------------------------------------------------------------------";
read -p "### ASK:  Exec phase-2? (wav-to-mp3 for each .disc-NN dir) [n|Y] " _answer;
if [ "X$_answer" = "Xy" ]; then
	_author_guess=$(pwd | awk -F'/' '{ print $(NF-1)}');
	_book_guess=$(pwd | awk -F'/' '{ print $(NF)}');
	_src_suffix_default="wav";
	_dst_suffix_default="mp3";
	_s2d_conv_cmdline_default="lame -b 192 -"; # _src2dst_converter_cmdline_invariant_default
	_mp3tag="mp3tag";
	#
	read -p "_author: [${_author_guess}] " _author;
	if [ "X$_author" = "X" ]; then _author=$_author_guess; fi
	read -p "_book: [${_book_guess}] " _book;
	if [ "X$_book" = "X" ]; then _book=$_book_guess; fi
	read -p "_src_suffix: [$_src_suffix_default] " _src_suffix;
	if [ "X$_src_suffix" = "X" ]; then _src_suffix=$_src_suffix_default; fi
	read -p "_dst_suffix: [$_dst_suffix_default] " _dst_suffix; 
	if [ "X$_dst_suffix" = "X" ]; then _dst_suffix=$_dst_suffix_default; fi
	read -p "_s2d_conv_cmdline: [$_s2d_conv_cmdline_default] " _s2d_conv_cmdline;
	if [ "X$_s2d_conv_cmdline" = "X" ]; then _s2d_conv_cmdline=$_s2d_conv_cmdline_default; fi
	#
	_dst_dir=".${_dst_suffix}.d";
	mkdir -p $_dst_dir;
	_file_prefix="${_author}--${_book}";
	_tmp_tracklist=".tmp.tracklist.txt";
	#
	find . -type f -name "track*.cdda.${_src_suffix}" > $_tmp_tracklist;
	_list_of_files=$(cat $_tmp_tracklist);
	for _i in $_list_of_files; do
		echo "### ";
		echo "### ________________________________________________________________________________________";
		_disc_no="$( echo $_i | awk -F '/' '{ print $2 }' | tr -s [:punct:] '_' | sed -e 's/_disc_/D/g' )";
		_track_no="$( echo $_i | awk -F '/' '{ print $3 }' | tr -s [:punct:] '_' | sed -e 's/track/T/g' | sed -e 's/_cdda_wav//g' )";
		_file_name="${_file_prefix}--${_disc_no}--${_track_no}.${_dst_suffix}";
		_file_path="${_dst_dir}/${_file_name}";
		_mp3_tag_artist="$_author";
		_mp3_tag_album="$_book";
		_mp3_tag_trackno="$( echo $_track_no | sed -e 's/T//g' | sed -e 's/^0*\([[:digit:]]\)/\1/g' )";
		_mp3_tag_songname="${_book}_${_disc_no}_${_track_no}";
		_mp3_tag_year="$(date +%Y)";
		echo "### INF:  cat  $_i  |  $_s2d_conv_cmdline  $_file_path";
		cat $_i | $_s2d_conv_cmdline $_file_path;
		echo "### INF:  $_mp3tag -a $_mp3_tag_artist -l $_mp3_tag_album -k $_mp3_tag_trackno -s $_mp3_tag_songname -y $_mp3_tag_year $_file_path";
		$_mp3tag -a "$_mp3_tag_artist" -l "$_mp3_tag_album" -k "$_mp3_tag_trackno" -s "$_mp3_tag_songname" -y "$_mp3_tag_year" "$_file_path";
	done
fi


