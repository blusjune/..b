#!/bin/bash
# .bdx.0100.y.ffmpeg.convert_to_mp3_from_m4a.sh
# 20230911_214422




_converter="ffmpeg";
_audio_codec="mp3";
_output_file_suffix="mp3";
_audio_channels="2";
_audio_bit_rate="192k";
_target_dir="mp3.d";
mkdir -p $_target_dir;




_list_input_files=$( ls -1 *.m4a | tr ' ' '_' ); #_list_input_files=$( ls -1 *.m4a | sed -e 's/\(.*\)/"\1"/g');
for _i in $_list_input_files; do
	_corename="$( echo $_i | sed -e 's/\(.*\)\.m4a/\1/g' )";
	echo "$_converter  -i $_i -acodec $_audio_codec -ac $_audio_channels -ab $_audio_bit_rate -loglevel error ${_target_dir}/${_corename}.${_output_file_suffix}";
	$_converter  -i $_i -acodec $_audio_codec -ac $_audio_channels -ab $_audio_bit_rate -loglevel error ${_target_dir}/${_corename}.${_output_file_suffix};
done




