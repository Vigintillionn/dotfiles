-- require("config.lazy")
-- require("lazy").setup("config.plugins")
print("Dotfiles loaded")
require("config.lazy")
require("config.keybinds")
require("config.lsp")
require("config.cmp")
require("config.editor")
require("config.telescope")
require("config.formatter")

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "lua",
        "rust",
        "javascript",
        "typescript",
        "c",
        "c_sharp",
        "java",
        "json",
        "python",
        "html",
        "css",
        "svelte",
        "haskell",
        "jsdoc"
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    modules = {},
    highlight = {
        enable = true,
        use_languagetree = true
    },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    }
}
