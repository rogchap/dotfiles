-- Treesitter for better syntax highlighting
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false, -- nvim-treesitter does not support lazy-loading
		config = function()
			-- Install parsers for these languages
			local languages = {
				"go",
				"lua",
				"rust",
				"dart",
				"json",
				"jsonc",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"yaml",
				"toml",
				"bash",
				"proto",
				"typescript",
				"javascript",
			}

			-- Install parsers asynchronously
			require("nvim-treesitter").install(languages)

			-- Enable treesitter highlighting for all configured languages
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"go",
					"lua",
					"rust",
					"dart",
					"json",
					"jsonc",
					"vim",
					"markdown",
					"yaml",
					"toml",
					"bash",
					"proto",
					"typescript",
					"javascript",
				},
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
}
