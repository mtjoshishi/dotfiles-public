local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "1000" })
  end
})

-- Remove whitespace on tail when save the file
autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e"
})

-- Don't auto commenting new line
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r, fo-=o"
})

-- Settings for filetypes
-------------------------

-- Config of cursor of width
-- C/C++/Python/Rust: 80 characters
-- Others: disable
augroup("SetLineLength", { clear = true })
autocmd("FileType", {
  group = "SetLineLength",
  pattern = {
    "text",
    "markdown",
    "html",
    "xml",
    "css",
    "javascript",
    "typescript",
  },
  command = "setlocal cc=0"
})
autocmd("FileType", {
  group = "SetLineLength",
  pattern = { "c", "cc", "cpp", "h", "hpp", "python", "rust", "cmake", "make" },
  command = "setlocal cc=80"
})

-- Config indent style
augroup("SetIndent", { clear = true })
autocmd("FileType", {
  group = "SetIndent",
  pattern = {
    "markdown",
    "html",
    "xml",
    "css",
    "javascript",
    "typescript",
    "json",
    "yaml",
    "toml",
    "lua",
    "cmake",
    "cpp",
    "cc",
  },
  command = "setlocal softtabstop=2 shiftwidth=2 tabstop=2 expandtab"
})
autocmd("FileType", {
  group = "SetIndent",
  pattern = { "python", "rust", },
  command = "setlocal softtabstop=4 shiftwidth=4 tabstop=4 expandtab"
})
autocmd("FileType", {
  group = "SetIndent",
  pattern = { "c", "make", },
  command = "setlocal softtabstop=8 shiftwidth=8 tabstop=8 noexpandtab"
})
