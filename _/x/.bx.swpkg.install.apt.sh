#!/bin/bash
#.bx.swpkg.install.apt.sh 
# 20230630_232320

_ts="date +%Y%m%d_%H%M%S";
declare -A _apt_pkg_phase;
_phase=0;


#### phase 1
_phase=$((_phase + 1));
_apt_pkg_phase[$_phase]="
git
emacs
vim
aptitude
sysstat
net-tools
gnuplot
r-base
w3m
itop
irqtop
htop
qtop
btop
atop
numatop
tiptop
usbtop
graphviz
proftpd
ncftp
idle-python3.10
ipython3
python3-ipython
python3-ipython-genutils
make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl cmake
mysql-server
mysql-client
gh
python3-pip
"


#### phase 2
_phase=$((_phase + 1));
_apt_pkg_phase[$_phase]="
xinit
wmaker
wmaker-common
wmaker-data
wmaker-utils
chromium-browser 
lightdm
gnome
xfce4

"


#### phase 3
_phase=$((_phase + 1));
_apt_pkg_phase[$_phase]="
mediawiki
phpmyadmin
latexml
vim-latexsuite
latex-make
latex-mk

vim-pathogen
openjdk-19-dbg
openjdk-19-doc
openjdk-19-jdk
openjdk-19-jre
openjdk-19-source

r-cran-findpython
vim-python-jedi
xscreensaver
language-pack-gnome-ko language-pack-gnome-ko-base language-pack-kde-ko language-pack-ko language-pack-ko-base
ibus-hangul libhangul-data libhangul-dev libhangul1
python-is-python3
pacman

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


#### phase 4
_phase=$((_phase + 1));
_apt_pkg_phase[$_phase]="
kde-full

"




manual_install__brave_browser()
{
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser
}


manual_install__vim_plug()
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


manual_install__vim_plantuml()
{
manual_install__vim_plug
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


manual_install__gem5()
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
	git clone https://${_GEM5_URL}/public/gem5
	cd gem5
	scons build/X86/gem5.opt -j ${_NUM_OF_CPU_CORES}
	#
	pip install gem5
	pip install gem5.benchmarks.gpt3
	#
	echo " build/X86/gem5.opt configs/learning_gem5/part1/simple.py "
}


manual_install()
{
	manual_install__brave_browser;
	manual_install__vim_plantuml;
	manual_install__gem5;
}




_i=0;
while [ $_i -lt $_phase ]; do
	_i=$((_i + 1));
	echo "phase[ $_i ]: " ${_apt_pkg_phase[$_i]};
	sudo apt install ${_apt_pkg_phase[$_i]};
done
# manual_install;
exit 0;
