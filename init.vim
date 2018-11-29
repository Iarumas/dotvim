" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=500		" keep 50 lines of command line history

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  "" For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78
  " Make it obvious where 80 characters is
  set textwidth=80
  set colorcolumn=+1

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"" User configuration
execute pathogen#infect()

set t_Co=16
set background=dark
colors solarized

let mapleader = ","

set wildmenu
set wildignore=*.o,*~,*.pyc
set ruler
set number
set numberwidth=5
set ignorecase
set smartcase
set hlsearch
set magic
set hidden
set showmatch
set mat=2
set encoding=utf8
set ffs=unix,dos,mac
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set ai
set si
set wrap
set autoread
set nobackup
set nowb
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set guifont=Inconsolata\ 10

map <silent> <leader><cr> :noh<cr>

nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

map <leader>sd :setlocal spell spelllang=de<cr>
map <leader>se :setlocal spell spelllang=en<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zs
map <leader>s? z=

" Save as root
cmap w!! %!sudo tee > /dev/null %

" Use deoplete
let g:deoplete#enable_at_startup = 1

" Splitting behaviour
set splitbelow
set splitright

" Julia Slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name":"default", "target_pane":":0.1"} 


"Python Paths
let g:python3_host_prog='C:/Python37/python.exe'
let g:python_host_prog='C:/Python27/python.exe'

" Lightline configuration
set laststatus=2

"" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:Syntastic_auto_loc_list = 1
let g:systastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"" NERDTree
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists(“s:std_in”) | NERDTree | endif
" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif

nmap <leader>nn :NERDTreeToggle<cr>
nnoremap <silent> <leader>nf :NERDTreeFind<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 25
let NERDTreeQuitOnOpen = 1

"" EasyMotion Stuff
" <Leader>f{char} to move to char
map <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader><Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader><Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>L <Plug>(easymotion-overwin-jk)

" Move to word
map <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

"" VimWiki/Gollum
let g:vimwiki_list = [{'path': '~/Dokumente/VimWiki/', 'syntax': 'markdown', 'ext': '.wiki'}]

au BufRead,BufNewFile *.wiki set filetype=vimwiki
:autocmd FileType vimwiki map <Leader>d :VimWikiMakeDiaryNote<cr>
function! ToggleCalendar()
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map <Leader>c :call ToggleCalendar()<cr>


"" GUndo
nmap <leader>gu :GundoToggle<cr>
let g:gundo_right = 1
let g:gundo_width = 60
let g:gundo_preview_height = 40

"" Unite
nnoremap <leader>f :Denite file_rec<cr>
"nnoremap <leader>fr :Denite file_rec/async<cr>
nnoremap <leader>b :Denite buffer<cr>
nnoremap <leader>g :Denite grep:.<cr>
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :Denite history/yank<cr>

"" Tagbar
let g:tagbar_ctags_bin='C:\Program Files\ctags58\ctags.exe'
let g:tagbar_width = 25
nmap <leader>tb :TagbarToggle<cr>

"" Vim-Latex & Arara
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf = 'arara -v %'

"" Mark
let g:mwDefaultHighlightingPalette = 'extended'

"" Vimux-Ipy TODO: Move to Python 
map <Leader>vi2 :call VimuxIpy("ipython2")<CR>
map <Leader>vi :call VimuxIpy("ipython")<CR>
vmap <silent> <Leader>e :python run_visual_code()<CR>
"noremap <silent> <Leader>c :python run_cell(save_position=False, cell_delim='# <codecell>')<CR>

"" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']


"" Calendar
let g:calendar_frame = 'default'


"" TODO: Auslagern, nur für tex files
function! CompileTex()
    silent write!
    call setqflist([])
    echon "compiling with arara ..."
    exec "lcd %:h"
    setlocal makeprg=arara\ -v\ %
    silent make!

    if !empty(getqflist())
        copen
        wincmd J
    else
        cclose
        redraw
        echon "successfully compiled"
    endif
endfunction

nnoremap <leader>ct :call CompileTex()<CR>

"nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr> 
