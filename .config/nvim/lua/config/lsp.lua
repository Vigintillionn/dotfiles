require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "lua_ls",
    "pylsp",
    "html",
    "eslint",
    "jsonls",
    "rust_analyzer",
  },
  automatic_enable = true,
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("pylsp")
vim.lsp.enable("ts_ls")
vim.lsp.enable("html")
vim.lsp.enable("eslint")
vim.lsp.enable("jsonls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("hls")
vim.lsp.enable("svelte-language-server")

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ['rust-analyzer'] = {
      diagnostic = {
        enable = true,
        disabled = { "unresolved-proc-macro" },
      },
      completion = {
        autoimport = {
          enable = true,
        }
      },
      checkOnSave = true,
      check = {
        command = "clippy",
      },
      assist = {
        importGranularity = "module",       -- "crate" / "module" / "item" / "preserve"
        importPrefix = "by_crate",          -- or "plain"
      },
    }
  }
})

vim.lsp.config("svelte-language-server", {
  settings = {
    ["svelte-language-server"] = {
      filetypes = { "svelte" }
    }
  }
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.lsp.config("pylsp", {
  cmd = { "pylsp" }, -- optional: the executable name; change if you installed differently
  settings = {
    pylsp = {
      -- Enable the Rope autoimport plugin and completions
      plugins = {
        -- core jedi completion (usually enabled by default)
        jedi_completion = { enabled = true, include_params = true },

        -- Rope autoimport plugin: enable the feature + completions + code-actions
        rope_autoimport = {
          enabled = true,
          -- completions enabled means typing `acos` will surface a completion candidate
          completions = { enabled = true },  -- this key is used in newer pylsp (rope_autoimport.completions.enabled)
          code_actions = { enabled = true }, -- quick-fix style code actions
          memory = false,                    -- optional: set true for memory-only DB (slow startup)
        },

        -- optional: rope_completion can help general rope completions (enable if you want)
        rope_completion = { enabled = true, eager = false },

        -- enable formatting / sorting etc if you use them
        pylsp_black = { enabled = true, line_length = 88 },
        pylsp_isort = { enabled = true },
        -- disable heavy checks you don't want:
        pyflakes = { enabled = false },
        pylsp_mypy = { enabled = false },
      },

      -- let rope inspect C-extension / builtin modules (very important for `math`)
      -- this is the same as `pylsp.rope.extensionModules` in pylsp CONFIG
      rope = {
        extensionModules = { "math", "sys", "os", "typing" },
      },
    },
  },
})

vim.lsp.config("hls", {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  settings = {
    haskell = {
      formattingProvider = "ormolu",       -- or "stylish-haskell", your choice
      checkProject = true,
    },
  },
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = 'Lsp: ' .. desc })
    end

    local tele = require("telescope.builtin")
    map('gd', tele.lsp_definitions, 'Goto Definition')
    map('<leader>fs', tele.lsp_document_symbols, 'Doc Symbols')
    map('<leader>fS', tele.lsp_dynamic_workspace_symbols, 'Dynamic Symbols')
    map('<leader>ft', tele.lsp_type_definitions, 'Goto Type')
    map('<leader>fr', tele.lsp_references, 'Goto References')
    map('<leader>fi', tele.lsp_implementations, 'Goto Impl')

    map('K', vim.lsp.buf.hover, 'hover')
    map('<leader>E', vim.diagnostic.open_float, 'diagnostic')
    map('<leader>k', vim.lsp.buf.signature_help, 'sig help')
    map('<leader>rn', vim.lsp.buf.rename, 'rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'code action')
    map('<leader>wf', vim.lsp.buf.format, 'format')

    vim.keymap.set('v',
      '<leader>ca',
      vim.lsp.buf.code_action, { buffer = ev.buf, desc = 'Lsp: code_action' })
  end,
})

vim.diagnostic.config({
  virtual_text = { prefix = '●', spacing = 4 },
  signs = true,
  underline = true,
  update_in_insert = false,
})
