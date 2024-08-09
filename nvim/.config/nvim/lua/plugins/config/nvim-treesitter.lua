require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash",
        "c",
        "gitignore",
        "go",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "swift",
        "vim",
        "vimdoc",
        "yaml",
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
    autotag = { enable = true },
}
