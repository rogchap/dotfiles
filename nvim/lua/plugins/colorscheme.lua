-- Nord colorscheme
return {
	"shaunsingh/nord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- Nord options
		vim.g.nord_contrast = true
		vim.g.nord_borders = false
		vim.g.nord_italic = true
		vim.g.nord_cursorline_transparent = false

		-- Load the colorscheme
		require("nord").set()

		-- Custom comment color override (from init.vim line 88)
		vim.api.nvim_set_hl(0, "Comment", { fg = "#7F8CAC", italic = true })
	end,
}
