local utils = require("utils/kmap_helper")
local nmap = utils.keymaps.nmap
local imap = utils.keymaps.imap
local opts = { buffer = true, silent = true, noremap = true }
local nowait = { buffer = true, silent = true, noremap = true, nowait = true }

return {
  {
    "Shougo/ddu.vim",
    lazy = false,
    enabled = true,
    dependencies = {
      "vim-denops/denops.vim",
      -- UI
      "Shougo/ddu-ui-ff",
      "Shougo/ddu-ui-filer",
      -- Source
      "Shougo/ddu-source-file",
      "matsui54/ddu-source-file_external",
      "Shougo/ddu-source-rg",
      "matsui54/ddu-source-help",
      -- Kind
      "Shougo/ddu-kind-file",
      -- Filter
      "Shougo/ddu-filter-sorter_alpha",
      "Shougo/ddu-filter-matcher_substring",
      -- Commands
      "Shougo/ddu-commands.vim",
      -- Column icons
      "ryota2357/ddu-column-icon_filename",
    },
    init = function()
      nmap(";f", "<Cmd>Ddu file_external<CR>")
      nmap(";h", "<Cmd>Ddu help<CR>")
      nmap(";rg", "<Cmd>Ddu -name=grep<CR>")
      nmap(";b", [[<Cmd>Ddu -name=filer -searchPath=`expand('%:p')`<CR>]])
    end,
    config = function()
      local resize_ui = function()
        local top = 4
        local current_width = vim.opt.columns:get()
        local current_height = vim.opt.lines:get()
        local ddu_window_width = math.floor(current_width * 0.5)
        local ddu_window_height = math.floor(current_height * 0.5)

        vim.fn["ddu#custom#patch_global"]({
          ui = "ff",
          uiParams = {
            ff = {
              winWidth = ddu_window_width,
              winHeight = ddu_window_height,
              winCol = math.floor((current_width - ddu_window_width) / 2),
              winRow = top,
              startFilter = true,
              split = "floating",
              floatingBorder = "single",
              floatingTitle = "File Explorer",
              floatingTitlePos = "center",
              previewFloating = true,
              previewFloatingBorder = "single",
              previewSplit = "vertical",
              previewWidth = math.floor(ddu_window_width * 0.5),
              previewHeight = ddu_window_height - 2,
              previewCol = math.floor(current_width / 2) - 2,
              previewRow = top + 1,
              filterSplitDirection = "floating",
              filterFloatingPosition = "top",
              autoResize = false,
              ignoreEmpty = false,
            },
          },
          sourceOptions = {
            _ = {
              ignoreCase = true,
              matchers = { "matcher_substring" },
            },
          },
          sourceParams = {
            file_external = {
              cmd = { "fd", ".", "-H", "-E", "__pycache__", "-t", "f" },
            },
            rg = {
              inputType = "regex",
              args = { "--json", "--column", "--no-heading", "--color", "never", "--hidden", "--glob", "!.git" },
            },
          },
          kindOptions = {
            file = {
              defaultAction = "open",
            },
            help = {
              defaultAction = "open",
            },
          },
        })
      end

      resize_ui()

      -- Recalculate the ff/filer's width when the windows is resized.
      vim.api.nvim_create_autocmd("VimResized", {
        pattern = "*",
        callback = resize_ui,
      })

      -- Live grep
      vim.fn["ddu#custom#patch_local"]("grep", {
        sources = {
          { name = "rg" },
        },
        sourceOptions = {
          rg = {
            matchers = {},
            volatile = true,
          },
        },
      })

      -- File explorer (filer)
      vim.fn["ddu#custom#patch_local"]("filer", {
        ui = "filer",
        sync = true,
        sources = {
          { name = "file" },
        },
        sourceOptions = {
          _ = {
            sorters = { "sorter_alpha" },
            columns = { "icon_filename" },
          },
        },
      })

      local ddu_common_keymaps = function()
        vim.wo.cursorline = true
        nmap("<CR>", "<Cmd>call ddu#ui#do_action('itemAction')<CR>", opts)
        nmap(
          "os",
          "<Cmd>call ddu#ui#do_action('itemAction', " ..
          "{'name': 'open', 'params': {'command': 'split'}})<CR>",
          opts
        )
        nmap(
          "ov",
          "<Cmd>call ddu#ui#do_action('itemAction', " ..
          "{'name': 'open', 'params': {'command': 'vsplit'}})<CR>",
          opts
        )
        nmap("<Space>", "<Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>", opts)
        nmap("q", "<Cmd>call ddu#ui#do_action('quit')<CR>", opts)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-filer",
        callback = function()
          ddu_common_keymaps()
          nmap("y", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'copy'})<CR>", opts)
          nmap("p", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'paste'})<CR>", opts)
          nmap("d", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>", opts)
          nmap("r", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'rename'})<CR>", opts)
          nmap("m", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'move'})<CR>", opts)
          nmap("nf", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'newFile'})<CR>", opts)
          nmap("nd", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'newDirectory'})<CR>", opts)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff",
        callback = function()
          ddu_common_keymaps()
          nmap("i", "<Cmd>call ddu#ui#do_action('openFilterWindow')<CR>", opts)
          nmap("K", "<Cmd>call ddu#ui#do_action('togglePreview')<CR>", opts)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff-filter",
        callback = function()
          nmap("q", "<Cmd>close<CR>", nowait)
          nmap("<CR>", "<Cmd>close<CR>", nowait)
          imap("<CR>", "<Esc><Cmd>close<CR>", opts)
        end
      })
    end,
  },
}
