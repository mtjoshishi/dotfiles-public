if !exists('g:loaded_nvim_treesitter')
    echom "Not loaded treesitter"
    finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    ensure_installed = {
        "rst",
        "yaml",
        "json",
        "html",
        "bash",
        "c",
        "cmake",
        "cpp",
        "python",
        "lua",
        "make",
        "perl",
        "rust",
        "toml",
        "vim"
    },
}
EOF
