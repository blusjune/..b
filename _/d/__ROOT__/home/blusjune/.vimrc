" 20230704_013146
set nu ai cin
set nocompatible
set ignorecase
syntax off
"Please
"Open this .vimrc file, and
"execute the ex command :PlugInstall
call plug#begin()
Plug 'aklt/plantuml-syntax'             " syntax hl for puml
Plug 'tyru/open-browser.vim'            " hooks for opeing browser
Plug 'weirongxu/plantuml-previewer.vim' " previewer
call plug#end()
