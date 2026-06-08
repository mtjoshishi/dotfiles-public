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
      -- Suppress "undefined global 'vim'" from LuaLS.
      -- ref: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
      vim.lsp.config("lua_ls", {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              -- Tell language srver which version of Lua you're using (most likely LuaJIT
              -- in the case of Neovim).
              version = "LuaJIT",
              -- Tell the language server how to find Lua modules same way as Neovim
              -- (see `:h lua-module-load`)
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- For LSP Settings Type Annotations: https://github.com/neovim/nvim-lspconfig#lsp-settings-type-annotations
                vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
              },
            }
          })
        end,
        settings = {
          Lua = {},
        },
      })

      require("lspconfig.ui.windows").default_options.border = "single"
      vim.lsp.buf.hover({ border = "single", title = "hover" })

      -- Display the error and warn into popup like vscode.
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          prefix = "■",
          format = function(d)
            local src = d.source and string.format("[%s]", d.source) or ""
            local code = d.code and string.format("(%s)", d.code) or ""
            return string.format("%s%s %s", src, code, d.message)
          end,
        },
        float = {
          source = "if_many",
          focusable = false,
          close_events = {
            "CursorMoved", "CursorMovedI", "BufHidden", "InsertEnter"
          },
        },
        severity_sort = true,
      })

      -- When cursor holds on the code, display warn/error info on popup.
      vim.api.nvim_create_autocmd("CursorHold", {
        pattern = "*",
        callback = function()
          if vim.api.nvim_get_mode().mode:match("^i") then return end
          local _, _ = vim.diagnostic.open_float(nil, {
            scope = "cursor",
          })
        end,
      })

      vim.o.updatetime = 300

      -- Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(_)
          nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
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
