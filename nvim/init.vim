" General configuration
" =====================

" no-compatible mode to vi
set nocompatible

" init autocmd
autocmd!

" text encoding
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,sjis,euc-jp,latin
set fileformats=unix,dos

syntax enable
set nobackup
" auto-reading if editting file updated
set autoread
" enable the editing a file while opening the buffer
set hidden
" show the command
set showcmd
" enable that yank to clipboard
set clipboard+=unnamedplus
set title
set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set visualbell
set showmatch
" cursor move time <time> * 0.1 sec.
set matchtime=1
set laststatus=2
set cmdheight=1
set wildmode=list:longest

" tab and indent
" --------------
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%,space:_
set autoindent
set smartindent
set cindent
set smarttab
" tabstop and expand-tab config for non-specified files
set expandtab
set tabstop=4
set shiftwidth=4

" tabstop and indent config by filetype
" TODO: external function and config files
if has("autocmd")
    " activate filetype search
    filetype plugin on
    " use the indent depends on filetype
    filetype indent on
    " sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab/noet=noexpandtab
    autocmd FileType c      setlocal sw=8 sts=8 ts=8 noet
    autocmd FileType h      setlocal sw=8 sts=8 ts=8 noet
    autocmd FileType cpp    setlocal sw=2 sts=2 ts=2 et
    autocmd FileType cc     setlocal sw=2 sts=2 ts=2 et
    autocmd FileType hpp    setlocal sw=2 sts=2 ts=2 et
    autocmd FileType html   setlocal sw=2 sts=2 ts=2 et
    autocmd FileType python setlocal sw=4 sts=4 ts=4 et
    autocmd FileType bash   setlocal sw=2 sts=2 ts=2 et
    autocmd FileType zsh    setlocal sw=2 sts=2 ts=2 et
    autocmd FileType cmake  setlocal sw=2 sts=2 ts=2 et
endif

" font
" ----
" Set font (hankaku)
set guifont=Fira\ Code\ 11
" Set font (zenkaku)"
set guifontwide=IBM\ Plex\ Sans\ JP\ Light\ 11
let g:airline_powerline_fonts = 1

"  search
" -------
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" plugins
" =======
runtime ./plugins.vim
runtime ./kmaps.vim

" if the swapfile exists, open in read-only mode
" ----------------------------------------------
" ref1: https://itchyny.hatenablog.com/entry/2014/12/25/090000
" ref2: https://github.com/uhooi/dotfiles/blob/3faeacc294a0244c38ea4a1350d52ad0fe8b2674/.vim/config/basics.vim 
augroup swapchoise_readonly
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
augroup END

" Config for path of python
" -------------------------
if has("win32")
    let g:python3_host_prog = '~\AppData\Local\Programs\Python\Python310\python.exe'
endif
