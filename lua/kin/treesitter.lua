require("nvim-treesitter.configs").setup({
    ensure_installed = { 
        "c",
        "lua",
        "vim",
        "vimdoc",
        "awk",
        "bash",
        "cmake",
        "comment",
        "css",
        "dockerfile",
        "doxygen",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "http",
        "latex",
        "luadoc",
        "make",
        "objdump",
        "perl",
        "python",
        "regex",
        "rust",
        "sql",
        "ssh_config",
        "strace",
        "terraform",
        "xml",
        "yaml",
    },

    sync_install = false,
    
    auto_install = true,

    highlight = {
        enable = true,
    }
})
