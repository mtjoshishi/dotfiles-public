-- Neovim configuration for myself.
-- Author: Makoto Teramoto, 2024.

if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
  vim.loader.enable()
end

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")
