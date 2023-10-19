# ./configure  --prefix=/home/blusjune/bxd/usr  --enable-shared  --enable-profiling  --enable-pystats  --with-pydebug  --with-valgrind  --with-dtrace
# ./configure  --prefix=/home/blusjune/bxd/usr  --enable-shared  --enable-profiling  --enable-pystats  --with-pydebug  --with-valgrind
# ./configure  --prefix=/home/blusjune/bxd/usr  --enable-profiling  --enable-pystats  --with-pydebug  --with-valgrind
#./configure  --prefix=/home/blusjune/bxd/usr  --enable-pystats
./configure  --prefix=/home/blusjune/bxd/usr
make -j clean
make -j
make install
