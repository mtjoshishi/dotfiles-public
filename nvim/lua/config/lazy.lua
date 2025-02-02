-- Configuration for lazy.nvim

-- Installation
-- ref: https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- First of all, install the LazyVim and import their plugins.
  spec = {
    { import = "plugins" }
  },
  defaults = {
    lazy = true,
    -- Always use the latest commit of git.
    version = false
  },
  install = { colorscheme = { "iceberg" } },
  checker = { enabled = true },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "netrwPlugins",
        "rplugins",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  }
})
