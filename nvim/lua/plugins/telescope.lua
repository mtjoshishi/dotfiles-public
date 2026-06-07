local utils = require("utils.kmap_helper")
local nmap = utils.keymaps.nmap

return {
  {
    "nvim-telescope/telescope.nvim",
    version = "0.2.2",
    lazy = false,
    dependencies = {
      -- 'plenary.nvim' will be archived soon, but still be dependencies.
      -- We'll see how it goes...
      "nvim-lua/plenary.nvim",
      { "nvim-tree/nvim-web-devicons", opts = {} },
      { "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S . -B build -DCMAKE_BUILD_TYPE=RelDebWithInfo && cmake --build build --config RelDebWithInfo --target install" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          -- Treat backslash ('\') on Windows's path.
          path_display = { "truncate" },
          mappings = {
            i = {
              ["<C-h>"] = "which_key",
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
            },
          },
        },
      })
      nmap("<leader>ff", "<cmd>Telescope find_files<CR>", { desc = 'Telescope find files' })
      nmap("<leader>fg", "<cmd>Telescope live_grep<CR>",  { desc = 'Telescope live grep' })
      nmap("<leader>fb", "<cmd>Telescope buffers<CR>",    { desc = 'Telescope buffers' })
      nmap("<leader>fh", "<cmd>Telescope help_tags<CR>",  { desc = 'Telescope help tags' })
    end
  }
}

