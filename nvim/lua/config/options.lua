vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "cp932", "euc-jp" }

vim.opt.fileformats = { "unix", "dos" }

vim.opt.title = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.virtualedit = "onemore"
vim.opt.visualbell  = true
vim.opt.cmdheight = 1
vim.opt.backup = false 
vim.opt.swapfile = false
vim.opt.hidden = true -- Turn off the 'unsaved' warning when switch the buffer.
vim.opt.autoread = true
vim.opt.listchars = {
  tab = '»-',
  trail = '-',
  eol = '↲',
  extends = '»',
  precedes = '«',
  nbsp = '%',
  space = '_'
}
vim.opt.wrap = false -- Don't wrap lines.
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true
vim.opt.splitbelow = true -- Put new windows under the current.
vim.opt.splitright = true -- Put new windows on the right side.
vim.opt.splitkeep = "cursor"

vim.opt.wildignore:append {
  "*.o",
  "*.a",
  "__pycache__",
  "*.pyc",
  "node_modules"
}

