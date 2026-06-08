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
  }
}
