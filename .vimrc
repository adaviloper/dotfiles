let mapleader = ","

set nocompatible              " be iMproved, required
filetype off                  " required

"  set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'airblade/vim-gitgutter'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'kaicataldo/material.vim'
Plugin 'mattn/emmet-vim'
Plugin 'sjl/gundo.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"-------------AutoCommands-------------"
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul





" Editor configurations
set background=dark
colorscheme material
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

set autoindent
set smartindent
set number relativenumber
set nu rnu
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
set updatetime=100

syntax enable
if (has("termguicolors"))
  set termguicolors
endif

"-------------VimGitGutter-------------"
"let g:gitgutter_override_sign_column_highlight = 0
"highlight SignColumn guibg=
highlight GitGutterAdd guifg=#C3E88D
highlight GitGutterChange guifg=#FFCB6B
highlight GitGutterDelete guifg=#F07178





"---------------Mappings---------------"
"Make it easier to edit the .vimrc file
nmap <Leader>ev :e $MYVIMRC<CR>
autocmd bufwritepost .vimrc source $MYVIMRC
nnoremap <Leader>ul :GundoToggle<CR>






"-------------NumberToggle-------------"
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END





