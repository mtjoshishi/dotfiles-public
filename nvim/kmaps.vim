" Keymaps configurations
" ======================

" shortcut keymap
nnoremap <ESC><ESC> :nohlsearch<CR><ESC> 
nnoremap j gj
nnoremap k gk

" leader setting and key rebind
let mapleader = "\<Space>"
" All select
nnoremap <Leader>a ggVG
" File open
nnoremap <Leader>o :CtrlP<CR>
" File save
nnoremap <Leader>w :w<CR>
" copy to clipboard and paste from clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Visual line mode
nmap <Leader><Leader> V

" increment / decrement
nnoremap + <C-a>
nnoremap - <C-x>

" yank to eol in a line
" ref: https://itchyny.hatenablog.com/entry/2014/12/25/090000
nnoremap Y y$

" clang-format's keymap
map <C-K> :pyf /usr/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/share/clang/clang-format.py<cr>
