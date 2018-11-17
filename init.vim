" Enable syntax highlighting
syntax on
"set background=dark
"colorscheme solarized

" Enable auto indentation custom per file type
filetype plugin indent on

" Set tabs to 4 space chars
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Set backspace behavior in insert mode
set backspace=indent,eol,start

" Disable beeps
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

execute pathogen#infect()
" execute pathogen#runtime_append_all_bundles()
execute pathogen#helptags()
