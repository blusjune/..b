#!/bin/bash
# .bx.swpkg.install.sh
# 20230630_232320


_prog_name_radix="swpkg.install";
_prog_name=".bx.${_prog_name_radix}.sh";
_ts="date +%Y%m%d_%H%M%S";
declare -A _install_group_descr;
declare -A _install_param;
declare -A _install_cmd;
_phase=0;
_exe_log=".exelog.${_prog_name_radix}.$($_ts).log";








################################################################################################
### { custom install functions
################################################################################################


custom_install__brave_browser()
{
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser
}


custom_install__freemind()
{
sudo snap install freemind
}


custom_install__vim_plug()
{
if [ ! -f ~/.vimrc ]; then
	echo ">>> Creating ~/.vimrc now. Because it does not exist";
	#_vimrc="~/.vimrc";
	#cat > $_vimrc << EOF	# this is not good because it generates error message 
				# "~/.vimrc: No such file or directory"
	cat > ~/.vimrc << EOF
" $($_ts)
set nu ai cin
set nocompatible
EOF
fi
# https://www.linuxfordevices.com/tutorials/linux/vim-plug-install-plugins
# VIM Plug: The easy way to install plugins in VIM
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}


custom_install__vim_plantuml()
{
custom_install__vim_plug
# It seems that ~/.vim/bundle/ is not the correct path
# correct path may be ~/.vim/plugged/
#
#mkdir -p ~/.vim/bundle
#cd ~/.vim/bundle/
#git clone https://github.com/aklt/plantuml-syntax
#git clone https://github.com/tyru/open-browser.vim.git
#git clone https://github.com/weirongxu/plantuml-previewer.vim.git
_is_it_installed=$(cat ~/.vimrc | grep plantuml-syntax | wc -l);
if [ "X$_is_it_installed" != "X1" ]; then
	# https://aasa.dev/posts/vim-plantuml/
	# Using PlantUML from VIM
	cat >> ~/.vimrc << EOF
"Please
"Open this .vimrc file, and
"execute the ex command :PlugInstall
call plug#begin()
Plug 'aklt/plantuml-syntax'             " syntax hl for puml
Plug 'tyru/open-browser.vim'            " hooks for opeing browser
Plug 'weirongxu/plantuml-previewer.vim' " previewer
call plug#end()
EOF
fi
	echo "Please open ~/.vimrc file, and execute the ex command :PlugInstall";
	read -p "Do you want to open and edit the file ~/.vimrc ? [Y|n] " _answer;
	if [ "X$_answer" != "Xn" ]; then
		vi ~/.vimrc;
	fi
}


custom_install__gem5()
{
	_GEM5_URL="gem5.googlesource.com"
	_NUM_OF_CPU_CORES="$( lscpu | grep "^CPU(s)" | awk '{ print $2 }' )"
	#
	sudo apt install libboost-all-dev
	sudo apt install scons
	sudo apt install m4 automake
	sudo apt install libprotobuf-dev protobuf-compiler libgoogle-perftools-dev libprotoc-dev libprotoc23 protobuf-c-compiler protobuf-compiler protobuf-compiler-grpc protobuf-compiler-grpc-java-plugin
	sudo apt install grpc-proto libgrpc++-dev libgrpc++1 libgrpc-dev libgrpc-java libgrpc10 python3-grpc-tools python3-grpcio 
	sudo apt install hdf5-tools libhdf5-dev libhdf5-doc libhdf5-hl-100 libhdf5-hl-cpp-100 libhdf5-hl-fortran-100 hdf5-helpers hdf5-plugin-lzf libhdf5-103 libhdf5-cpp-103
	sudo apt install libtcmalloc-minimal4
	#
	if [ -d gem5 ]; then
		echo ">>> gem5 directory exists";
		( cd gem5;
		git pull;
		)
	else
		echo ">>> gem5 directory does not exists";
		( cd .bxd/src; 
		git clone https://${_GEM5_URL}/public/gem5;
		)
	fi
	cd gem5;
	scons build/X86/gem5.opt -j ${_NUM_OF_CPU_CORES}
	#
	pip install gem5
	pip install gem5.benchmarks.gpt3
	#
	echo " build/X86/gem5.opt configs/learning_gem5/part1/simple.py "
}


################################################################################################
### } custom install functions
################################################################################################




################################################################################################
### { apt install functions
################################################################################################


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="Essential;"
_install_param[$_phase]="
vim emacs bluefish kwrite
git gh
w3m
aptitude
sysstat net-tools gparted rsync
r-base gnuplot
r-cran-findpython
itop irqtop htop qtop btop atop numatop tiptop usbtop
graphviz imagemagick
proftpd-core ncftp
exuberant-ctags cscope
ipython3 python3-ipython python3-ipython-genutils python3-pip idle idle-python3.10 pyprof2calltree
vim-python-jedi
python-is-python3
meld kompare diffuse
vim-latexsuite vim-pathogen
plantuml
latexml latex-make latex-mk
qemu-kvm
jq
make build-essential clang libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl cmake gtkwave iverilog verilator
plocate dkms
npm
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="Database;"
_install_param[$_phase]="
mysql-server
mysql-client
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="X Windows Systems - Essential;"
_install_param[$_phase]="
xinit
wmaker
wmaker-common
wmaker-data
wmaker-utils
chromium-browser 
xfce4
xscreensaver
xscreensaver-data
xscreensaver-data-extra
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="X Windows Systems - Advanced;"
_install_param[$_phase]="
kde-full
sddm
plasma-desktop
kde-plasma-desktop
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="PDF;"
_install_param[$_phase]="
pdf2svg pdfchain pdfgrep pdfmod pdfposter pdfproctools pdfsam qpdf qpdfview xpdf
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="File Manager;"
_install_param[$_phase]="
krusader nemo xfe nnn
krename
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="Web;"
_install_param[$_phase]="
mediawiki
composer
apache2
phpmyadmin
httrack
webhttrack
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="Java;"
_install_param[$_phase]="
openjdk-19-dbg openjdk-19-doc openjdk-19-jdk openjdk-19-jre openjdk-19-source
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="Office; Image; Sound; Picture; Photo; Audio; Music;"
_install_param[$_phase]="
libreoffice libreoffice-plasma
gimp
kphotoalbum eog gwenview
ffmpeg cdparanoia k3b sound-juicer
mp3blaster lxmusic music123 elisa clementine rhythmbox cmus qmmp
audacity audacious
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="Hangul Input;"
_install_param[$_phase]="
language-pack-kde-ko language-pack-ko language-pack-ko-base
ibus-hangul libhangul-data libhangul-dev libhangul1
fonts-baekmuk
fonts-lexi-gulim
fonts-lexi-saebom
fonts-nanum
fonts-nanum-eco
fonts-nanum-extra
fonts-naver-d2coding
fonts-unfonts-core
fonts-unfonts-extra
fonts-woowa-bm
xfonts-baekmuk
cairosvg
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="System Performance Benchmark;"
_install_param[$_phase]="
fio
gfio
blktrace
sysbench
iperf
ndctl
nvme-cli
acpi
"
_install_cmd[$_phase]="sudo apt install";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="Brave Browser;"
_install_param[$_phase]="
custom_install__brave_browser
"
_install_cmd[$_phase]=" ";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="Freemind;"
_install_param[$_phase]="
custom_install__freemind
"
_install_cmd[$_phase]=" ";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="PlantUML - VIM;"
_install_param[$_phase]="
custom_install__vim_plantuml
"
_install_cmd[$_phase]=" ";


#### phase++
_phase=$((_phase + 1));
_install_group_descr[$_phase]="Gem5;"
_install_param[$_phase]="
custom_install__gem5
"
_install_cmd[$_phase]=" ";


################################################################################################
### } apt install functions
################################################################################################








################################################################################################
### { main loop
################################################################################################


echo "";
echo "### Execution log will be saved in $_exe_log";
_i=0;
while [ $_i -lt $_phase ]; do
	_i=$((_i + 1));
	echo "";
	echo "_____________";
	echo "phase[ $_i ]: ${_install_group_descr[$_i]} :: " ${_install_param[$_i]};
	read -p ">>> Execute? [Y(yes)|s(skip)|t(terminate)] " _answer;
	case $_answer in 
		"y"|"Y")
			echo "### $($_ts) :EXEC: phase[ $_i ]: ${_install_group_descr[$_i]} :: " ${_install_param[$_i]} | tee -a $_exe_log;
			${_install_cmd[$_i]} ${_install_param[$_i]};
			;;
		"s"|"S"|"n"|"N")
			echo "### $($_ts) :SKIP: phase[ $_i ]: ${_install_group_descr[$_i]} :: " ${_install_param[$_i]} | tee -a $_exe_log;
			;;
		"t"|"T")
			echo "### $($_ts) :TERM: terminate this installation loop" | tee -a $_exe_log;
			break;
			;;
		*)
			echo "### $($_ts) :SKIP: phase[ $_i ]: ${_install_group_descr[$_i]} :: " ${_install_param[$_i]} | tee -a $_exe_log;
			;;
	esac
#	if [ "X$_answer" = "Xy" ]; then
#		echo "phase[ $_i ]: " ${_install_param[$_i]} >> $_exe_log;
#		sudo apt install ${_install_param[$_i]};
#	fi
done


################################################################################################
### } main loop
################################################################################################


exit 0;








