_db_dump_dir="bxd_obj_mediawiki";

mysqldump -u neo -p --databases matrix > ${_db_dump_dir}/mediawiki_db_dump.matrix.$(..ts).sql
