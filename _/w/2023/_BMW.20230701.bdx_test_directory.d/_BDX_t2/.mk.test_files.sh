mkdir -p dir_01 dir_02;

(cd dir_01;
_cmd_list="
.bdx.1100.y.dir_01.aerosmith.sh
.bdx.1200.y.dir_01.beatles.sh
.bdx.1300.y.dir_01.coldplay.sh
.bdx.1400.y.dir_01.doors.sh
.bdx.1500.y.dir_01.elvis_costello.sh
";
for _i in $_cmd_list; do
	echo "sleep 1;" > $_i;
	chmod 755 $_i;
done
)

(cd dir_02;
_cmd_list="
.bdx.2100.y.dir_02.aerosmith.sh
.bdx.2200.y.dir_02.beatles.sh
.bdx.2300.y.dir_02.coldplay.sh
.bdx.2400.y.dir_02.doors.sh
.bdx.2500.y.dir_02.elvis_costello.sh
";
for _i in $_cmd_list; do
	echo "sleep 1;" > $_i;
	chmod 755 $_i;
done
)
