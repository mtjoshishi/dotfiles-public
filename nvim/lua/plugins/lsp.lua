local utils = require("utils.kmap_helper")
local nmap = utils.keymaps.nmap

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "Shougo/ddc-source-lsp",
      -- Java language server (jdtls)
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      require("lspconfig.ui.windows").default_options.border = "single"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
        -- Use a sharp border with 'FloatBorder' highlishgts
        border = "single",
        title = "hover",
      })

      require("mason").setup()
      require("mason-lspconfig").setup()

      local lspconfig = require("lspconfig")
      local ddc_source_lsp = require("ddc_source_lsp")
      local ddc_capabilities = ddc_source_lsp.make_client_capabilities()

      require("mason-lspconfig").setup_handlers({
        function(server)
          lspconfig[server].setup({ capabilities = ddc_capabilities })
        end
      })

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
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "tsserver",
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
        "jdtls",
        "jsonls",
        "ltex",
        "pyright",
        "typos_lsp",
      },
      automatic_installation = true
    },
  },
  {
    "williamboman/mason.nvim",
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
  {
    "mfussenegger/nvim-jdtls",
    config = function()
      local jdtls_cfg = {
        cmd = { "jdtls" },
        root_dir = vim.fs.dirname(
          vim.fs.find({"gradlew", ".git", "mvnw"}, { upward = true })[1]
        ),
      }
      require("jdtls").start_or_attach(jdtls_cfg)
    end,
  },
}
