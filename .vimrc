set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugin that dynamically switches between relative and absolute line-numbers
Plugin 'jeffkreeftmeijer/vim-numbertoggle.git'
" Also needs 'sudo pip install ino'
Plugin 'https://github.com/jplaut/vim-arduino-ino'
Plugin 'https://github.com/lambdalisue/vim-fullscreen'
Plugin 'https://github.com/tpope/vim-surround'
Plugin 'https://github.com/sophacles/vim-processing'

" more Plugin commands
" ...
call vundle#end()            " required
filetype plugin indent on    " required

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb =

set guifont=Anonymous\ Pro\ 14
colorscheme vividchalk

syntax enable "enable syntax processing

set tabstop=4     " Number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set expandtab     " tabs are spaces

set number        " shows line numbers
set numberwidth=3 " line numbers take up less space
set showcmd       " show command in bottom right
set cursorline    " highlight current line
set wildmenu      " visual autocomplete menu, press tab to cycle through options
set showmatch     " highlight matching brackety things
set incsearch     " search as characters are entered
set hlsearch      " highlight matches
set encoding=utf-8  "everything's in unicode now!
set list          "print trailing characters
set listchars=tab:▸\ ,eol:¬ "print a little character at the end of each line

"move vertically by visual line (for long lines)
nnoremap j gj
nnoremap k gk
"
" visually select the last text entered
nnoremap gV `[v`] 

" make next and previous searches center the view on the new item
nnoremap n nzzzv
nnoremap N Nzzzv

" Make N and L go to the beginning and ends of a line easily
nnoremap H ^
nnoremap L g_

" Make , repeat the last single line find (;)
" and repeat the last command (.)
noremap , ;.

" split line with S
nnoremap S i<cr><esc><right>

" kill trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" remap annoying accidental quitting/writing
:command WQ wq
:command Wq wq
:command W w
:command Q q
:command E e

inoremap <Up>     <NOP>
inoremap <Down>   <NOP>
inoremap <Left>   <NOP>
inoremap <Right>  <NOP>
noremap  <Up>     <NOP>
noremap  <Down>   <NOP>
noremap  <Left>   <NOP>
noremap  <Right>  <NOP>

noremap <Left> <Home>
noremap <Right> <End>

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar

"Do the last operation and move up or down a line
nmap <C-Down> j.
nmap <C-Up> k.

"syntastic config:
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
