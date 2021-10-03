" plugins management
" ==================
" All plugins managed by Shougo/dein.vim
" url: https://github.com/Shougo/dein.vi://github.com/Shougo/dein.vim
" ref: https://github.com/uhooi/dotfiles/blob/main/.vim/config/plugins.vim

if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')

" get the runtime absolute-path by OS
if has('win32') || has('win64')
    let s:dein_run_path = s:dein_dir .. '\repos\github.com\Shougo\dein.vim'
else
    " linux / unix
    let s:dein_run_path = s:dein_dir .. '/repos/github.com/Shougo/dein.vim'
endif

execute 'set runtimepath+=' . s:dein_run_path

if !dein#load_state(s:dein_dir)
    finish
endif

call dein#begin(s:dein_dir)

" Let dein manage dein
call dein#add(s:dein_run_path)
" cool ui for Shougo/dein.vim
call dein#add('wsdjeg/dein-ui.vim')

let s:dein_toml_dir = stdpath('config') . expand('/.dein_toml')
call dein#load_toml(s:dein_toml_dir . expand('/dein.toml'), {'lazy': 0})
" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

call dein#end()
call dein#save_state()

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
