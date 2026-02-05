-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		html = {
			require("config.prettier_formater")
		},
		json = {
			require("config.prettier_formater")
		},
		jsonc = {
			require("config.prettier_formater")
		},
		css = {
			require("config.prettier_formater")
		},
		javascript = {
			require("config.prettier_formater")
		},
		typescript = {
			require("config.prettier_formater")
		},
		cs = {
			require("formatter.filetypes.cs").clangformat
		},
        rust = {
            require("formatter.filetypes.rust").rustfmt
        }
	}
}
