return {
  {
    "cocopon/iceberg.vim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme iceberg]])
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
    end
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return { transparent = true }
    end
  },
}
