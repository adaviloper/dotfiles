Plugin 'vimwiki/vimwiki'

let wikiDir = '~/vimwiki'
let templateDir = '~/.vim/rcplugins/wiki-templates'

let g:vimwiki_list = [{'path': wikiDir . '/the-disappearance-of-winters-daughter', 
                     \ 'template_path': templateDir . '/',
                     \ 'template_default': 'default',
                     \ 'auto_toc': 1,
                     \ 'auto_tag': 1}]

nmap <Leader>wH :VimwikiAll2HTML<Enter><Enter>
