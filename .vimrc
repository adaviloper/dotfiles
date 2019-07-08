let mapleader = ","

set nocompatible              " be iMproved, required
filetype on                   " required

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
Plugin 'mattn/emmet-vim'
Plugin 'sjl/gundo.vim'
Plugin 'kaicataldo/material.vim'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'HerringtonDarkholme/yats.vim'

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
syntax on

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme material

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

highlight Search cterm=underline

highlight Cursor guifg=white guibg=#E91E63
highlight iCursor guifg=white guibg=#E91E63
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

set autoindent
set copyindent
set smartindent

set mouse=a
set number relativenumber
set nu rnu
set splitbelow
set splitright
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
set updatetime=100
set wildignore+=*/vendor/**
set wildignore+=*/node_modules/**

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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nmap <C-v> :vertical resize +5<CR>







"-------------NumberToggle-------------"
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END





"-------------TagbarToggle-------------"
let g:tagbar_show_visibility=1
nnoremap <silent> <Leader>tb :TagbarToggle<CR>
