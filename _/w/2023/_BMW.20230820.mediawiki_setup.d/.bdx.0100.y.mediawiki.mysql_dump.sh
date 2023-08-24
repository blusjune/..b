_db_dump_dir="bxd_obj_mediawiki";

_db_name="matrix_radiohead";
#_db_name="matrix";

mysqldump -u neo -p --databases $_db_name > ${_db_dump_dir}/mediawiki_db_dump.${_db_name}.$(..ts).sql
