require("config")

vim.o.background = "dark"
vim.cmd("colorscheme kanagawa-paper-ink")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"typescript", "javascript", "lua"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "kanagawa-paper-ink",
    }
})

vim.diagnostic.config({
  -- update_in_insert = true, -- This is the default causing the lag
  update_in_insert = false, -- Change this to false
})
