local h = require("utils.kmap_helper")
local keymap = h.keymaps

return {
  {
    "tpope/vim-fugitive",
    config = function()
      keymap.nmap("<leader>gd", "<cmd>Git diff<CR>")
      keymap.nmap("<leader>gs", "<cmd>Git<CR>")
      keymap.nmap("<leader>gl", "<cmd>Git log<CR>")
      keymap.nmap("<leader>gc", "<cmd>Git commit -s<CR>")
      keymap.nmap("<leader>gC", "<cmd>Git commit --amend<CR>")
      keymap.nmap("<leader>gb", "<cmd>Git blame<CR>")
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs               = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged        = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged_enable = true,
      signcolumn          = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl               = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl              = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff           = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir        = {
        follow_files = true
      },
      on_attach           = function(bufnr)
        local gitsigns = package.loaded.gitsigns

        keymap.nmap("c]", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { buffer = bufnr, desc = "Next hunk", silent = true })

        keymap.nmap("[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { buffer = bufnr, desc = "Previous hunk", silent = true })

        keymap.nmap("<leader>ghs", gitsigns.stage_hunk)
        keymap.vmap("<leader>ghs", function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        keymap.nmap("<leader>ghr", gitsigns.reset_hunk)
        keymap.vmap("<leader>ghr", function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)

        keymap.nmap("<leader>ghb", function()
          gitsigns.blame_line({ full = true })
        end)

        keymap.nmap("<leader>ghd", gitsigns.diffthis)
      end
    },
  }
}
