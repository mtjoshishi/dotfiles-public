return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<Tab>",   "<cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    config = true,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { [[<C-\>]], mode = { 'n', 't' }, desc = "Toggle Terminal" },
    },
    opts = {
      open_mapping = [[<C-\>]],
      direction = "horizontal",
      size = 20,
    },
    config = true,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.utils.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.utils.stylize_markdown"] = true,
          },
        },
        presets = {
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
      })
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", ";e", "<cmd>NvimTreeToggle<CR>",
        {
          silent = true,
          desc = "nvim-tree: Toggle",
          noremap = true,
          nowait = true
        })
      vim.keymap.set("n", ";f", "<cmd>NvimTreeFindFileToggle<CR>",
        {
          silent = true,
          desc = "nvim-tree: Find file",
          noremap = true,
          nowait = true
        })

      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- default mappings
        api.map.on_attach.default(bufnr)

        -- custom mappings
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      end

      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
        on_attach = my_on_attach,
      })
    end
  },
}
