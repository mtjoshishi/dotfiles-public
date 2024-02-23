-- Neovim configuration for myself.
-- Author: Makoto Teramoto, 2024.

if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
  vim.loader.enable()
end

-- To suppress 'You need to set 'vim.g.mapleader' **BEFORE** loading lazy',
-- call options at first.
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
