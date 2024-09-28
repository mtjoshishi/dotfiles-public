return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        autotag = { enable = true },
        highlight = { enable = true },
        auto_install = true,
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "cpp",
          "css",
          "dockerfile",
          "go",
          "gomod",
          "html",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "make",
          "markdown",
          "python",
          "regex",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
      })
    end,
  }
}
