return {
  {
    -- Code formatter
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatter_by_ft = {
          c = { "clang-format" },
          cpp = { "clang-format" },
          lua = { "stylua" },
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          rust = { "rustfmt", lsp_format = "fallback" },
          ["*"] = { "codespell" },
          ["_"] = { "trim_whitespace" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = {
          lsp_format = "fallback",
          timeout_ms = 500,
        }
      })
    end
  },
}
