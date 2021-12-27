" Editor configurations
syntax on

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme nord
" Acceptable values are 'default' | 'dark' | 'palenight'
let g:material_theme_style = 'default'

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

if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Inconsolata\ for\ Powerline:h15
   endif
endif
