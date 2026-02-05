return {
    {
        'sainnhe/everforest',
        lazy = false,  -- load immediately
    },
    {
      "thesimonho/kanagawa-paper.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    { "neovim/nvim-lspconfig" },
    { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { 'mfussenegger/nvim-lint', },
    { 'mfussenegger/nvim-dap' },
    {
      "prettier/vim-prettier",
      build = false,
      ft = {
        "javascript", "typescript", "css", "scss", "json",
        "markdown", "vue", "html", "yaml", "graphql", "tsx", "jsx"
      },
      config = function()
        -- Automatically run Prettier on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = {
            "*.js", "*.jsx", "*.mts", "*.mjs", "*.ts", "*.tsx", "*.css",
            "*.scss", "*.json", "*.md", "*.vue", "*.html", "*.yaml", "*.graphql"
          },
          command = "PrettierAsync"
        })

        -- Optional Prettier config overrides
        vim.g["prettier#config#print_width"] = 120
        vim.g["prettier#config#trailing_comma"] = "all"
        vim.g["prettier#config#tab_width"] = 2
      end
    },
    { 'mhartington/formatter.nvim' },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- or , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = false,
                    theme = "kanagawa-paper-ink",
                }
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
    { "folke/tokyonight.nvim",    name = "tokyo",      priority = 1000 },
    { "navarasu/onedark.nvim",    name = "onedark",    priority = 1000 },
    { "ellisonleao/gruvbox.nvim", priority = 1000,     config = true,  opts = ... },
    {
        "mfussenegger/nvim-jdtls"
    },
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
    {
        "xero/miasma.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme miasma")
        end,
    },
    { "EdenEast/nightfox.nvim" },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end,
    },
    {
        "nobbmaestro/nvim-andromeda",
        dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" }
    },
    {
        "windwp/nvim-autopairs",
        event="InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({
                check_ts = true,
                enable_check_bracket_line = false,
                fast_wrap = {}
            })
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )
        end,
    },
  {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup({
          enable = true,
          filetypes = { "html", "xml", "svelte", "javascript", "typescript", "vue", "jsx", "tsx" },
        })
      end,
    },
}
