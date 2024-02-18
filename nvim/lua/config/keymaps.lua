local utils = require("utils/kmap_helper")
local nmap = utils.keymaps.nmap
local vmap = utils.keymaps.vmap

local opts = { noremap = true, silent = true }

-- Several shortcut keymaps
nmap("<ESC><ESC>", ":nohlsearch<CR><ESC>", opts)
nmap("j", "gj", opts)
nmap("k", "gk", opts)
nmap("<Leader><Leader>", "V")

-- select all
nmap("<Leader>a", "gg<S-v>G", opts)

-- File open
nmap("<Leader>o", ":CtrlP<CR>", opts)

-- File save
nmap("<Leader>w", ":w<CR>", opts)

-- Increment/decrement
nmap("+", "<C-a>", opts)
nmap("-", "<C-x>", opts)

-- Copy and paste in visual mode
vmap("<Leader>y", '"+y')
vmap("<Leader>d", '"+d')
nmap("<Leader>p", '"+p')
nmap("<Leader>p", '"+p')
vmap("<Leader>P", '"+P')
vmap("<Leader>P", '"+P')

-- Yank to EOL
nmap("Y", "y$", opts)

-- Tab
nmap("te", ":tabedit")
nmap("<Tab>", ":tabnext<CR>", opts)
nmap("<S-Tab>", ":tabprev<CR>", opts)

-- Split window
nmap("ss", ":split<CR>", opts)
nmap("sv", ":vsplit<CR>", opts)

-- Move windows
nmap("swh", "<C-w>h")
nmap("swk", "<C-w>k")
nmap("swj", "<C-w>j")
nmap("swl", "<C-w>l")
