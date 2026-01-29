-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
	-- Import plugin specs from separate files
	{ import = "plugins.colorscheme" },
	{ import = "plugins.ui" },
	{ import = "plugins.telescope" },
	{ import = "plugins.lsp" },
	{ import = "plugins.completion" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.editor" },
	{ import = "plugins.git" },
	{ import = "plugins.opencode" },
}, {
	-- Lazy.nvim configuration
	ui = {
		border = "rounded",
	},
	checker = {
		enabled = false, -- Don't auto-check for updates
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
