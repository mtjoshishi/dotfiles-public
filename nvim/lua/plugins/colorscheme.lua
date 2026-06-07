return {
  {
    "cocopon/iceberg.vim",
    enabled = true,
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
    end
  },
  {
    "craftzdog/solarized-osaka.nvim",
    opts = function()
      return { transparent = true }
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local catppuccin = require("catppuccin")
      catppuccin.setup({
        flavor = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        float = {
          transparent = false,
          solid = false,
        },
        term_colors = false,
      })
      vim.cmd.colorscheme "catppuccin"
    end
  },
}
