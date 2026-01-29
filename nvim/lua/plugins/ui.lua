-- UI plugins: lualine (statusline) + which-key (keybinding hints)
return {
	-- Statusline (replaces lightline)
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					theme = "nord",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"filename",
							path = 1, -- Relative path
							fmt = function(str)
								-- Custom filename logic from init.vim:123-130
								local git_dir = vim.b.git_dir
								if git_dir then
									local root = vim.fn.fnamemodify(git_dir, ":h")
									local path = vim.fn.expand("%:p")
									if vim.startswith(path, root) then
										return path:sub(#root + 2)
									end
								end
								return vim.fn.expand("%")
							end,
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},

	-- Keybinding hints
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				delay = 500,
				plugins = {
					spelling = true,
				},
			})

			-- Register keybinding groups
			wk.add({
				{ "<leader>c", group = "OpenCode" },
				{ "<leader>t", desc = "Find files" },
				{ "<leader>f", desc = "Live grep" },
				{ "<leader>g", desc = "Lazygit" },
				{ "<leader><leader>", desc = "Previous file" },
				{ "<leader><cr>", desc = "Go to definition" },
				{ "<leader>rn", desc = "Rename" },
				{ "<leader>a", desc = "Code actions" },
			})
		end,
	},
}
