local utils = require("utils/kmap_helper")
local imap = utils.keymaps.imap
local opts = { noremap = true, silent = true }

return {
  {
    "Shougo/ddc.vim",
    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      -- UI
      "Shougo/pum.vim",
      "Shougo/ddc-ui-pum",
      -- Source
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-lsp",
      "uga-rosa/ddc-source-vsnip",
      -- filter
      "tani/ddc-fuzzy",
    },
    init = function()
    end,
    config = function()
      local patch_global = vim.fn["ddc#custom#patch_global"]

      patch_global("ui", "pum")

      patch_global("sources", {
        "around",
        "lsp",
      })

      patch_global("sourceOptions", {
        _ = {
          matchers = { "matcher_fuzzy" },
          sorters = { "sorter_fuzzy" },
          converters = { "converter_fuzzy" },
        },
        around = {
          mark = "[A]",
        },
        lsp = {
          mark = "[LSP]",
          keywordPattern = "[a-zA-Z0-9_À-ÿ$#\\-*]*",
          forceCompletionPattern = [["\.\w*|:\w*|->\w*"]],
          sorters = { "sorter_lsp-kind", "sorter_fuzzy" },
        }
      })

      patch_global("sourceParams", {
        lsp = {
          snippetEngine = vim.fn["denops#callback#register"](function(body)
            vim.fn["vsnip#anonymous"](body)
          end),
          enableResolveItem = true,
          enableAdditionalTextEdit = true,
        },
      })

      vim.fn["ddc#enable"]()
    end,
  },
  {
    "Shougo/pum.vim",
    config = function()
      vim.cmd(
        [[inoremap <silent><expr> <Tab>..
        \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
        \ '<Tab>' : ddc#map#manual_complete()]]
      )
      imap("<S-Tab>", "<Cmd>call pum#map#insert_relative(-1)<CR>", opts)
      imap("<C-n>", "<Cmd>call pum#map#select_relative(+1)<CR>", opts)
      imap("<C-p>", "<Cmd>call pum#map#select_relative(-1)<CR>", opts)
      imap("<C-y>", "<Cmd>call pum#map#confirm()<CR>", opts)
      imap("<C-e>", "<Cmd>call pum#map#cancel()<CR>", opts)
      imap("<PageDown>", "<Cmd>call pum#map#select_relative_page(+1)<CR>", opts)
      imap("<PageUp>", "<Cmd>call pum#map#select_relative_page(-1)<CR>", opts)
    end
  },
  {
    "hrsh7th/vim-vsnip",
    lazy = false,
    config = function()
      vim.cmd("imap <expr> <C-l> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-l>'")
      vim.cmd("smap <expr> <C-l> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-l>'")
      vim.cmd("imap <expr> <C-h> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-h>'")
      vim.cmd("smap <expr> <C-h> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-h>'")
    end,
  }
}

