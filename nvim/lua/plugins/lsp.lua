local utils = require("utils.kmap_helper")
local nmap = utils.keymaps.nmap

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("lspconfig.ui.windows").default_options.border = "single"
      vim.lsp.buf.hover({ border = "single", title = "hover" })

      -- Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(_)
          nmap('K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
          nmap('gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
          nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
          nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
          nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
          nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
          nmap('gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
          nmap('gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
          nmap('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
          nmap('ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
          nmap('g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
          nmap('g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        end
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",
        "denols",
        "lua_ls",
        "yamlls",
        "bashls",
        "clangd",
        "cmake",
        "cssls",
        "gopls",
        "html",
        "htmx",
        "jsonls",
        "ltex",
        "pyright",
        "typos_lsp",
        "rust_analyzer",
        "zls",
      },
      automatic_installation = true
    },
    dependencies = {
      { "mason-org/mason.nvim", },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "single",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
      },
    },
  },
}
