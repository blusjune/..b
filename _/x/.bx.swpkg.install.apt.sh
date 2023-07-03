#!/bin/bash
#.bx.swpkg.install.apt.sh 
# 20230630_232320

_ts="date +%Y%m%d_%H%M%S";

APT_PKG_LIST="
aptitude
sysstat
net-tools
gnuplot
r-base
wmaker
wmaker-common
wmaker-data
wmaker-utils
xinit
kde-full
xfce4
gnome
chromium-browser 
emacs
mysql-server
mysql-client
phpmyadmin
mediawiki
latexml
vim-latexsuite
latex-make
latex-mk
itop
irqtop
htop
qtop
btop
atop
numatop
tiptop
usbtop
idle-python3.10
ipython3
python3-ipython
python3-ipython-genutils
r-cran-findpython
vim-python-jedi
make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
w3m
python3-pip
xscreensaver
language-pack-gnome-ko language-pack-gnome-ko-base language-pack-kde-ko language-pack-ko language-pack-ko-base
ibus-hangul libhangul-data libhangul-dev libhangul1
lightdm
python-is-python3
cmake
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

vim-pathogen
openjdk-19-dbg
openjdk-19-doc
openjdk-19-jdk
openjdk-19-jre
openjdk-19-source
graphviz
"

sudo apt install $APT_PKG_LIST







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


#manual_install__brave_browser
manual_install__vim_plantuml

