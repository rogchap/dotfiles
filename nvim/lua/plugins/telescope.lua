-- Telescope fuzzy finder (replaces fzf + fzf.vim)
return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.1", -- Updated for Neovim 0.11 compatibility (fixes treesitter API)
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>t", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>f", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					-- Use ripgrep with similar settings to your ag setup
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob",
						"!.git/",
					},

					-- Layout similar to your FZF tmux popup setup
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							width = 0.9,
							height = 0.6,
							preview_width = 0.5,
						},
					},

					-- Improved sorting
					sorting_strategy = "ascending",
					prompt_prefix = "  ",
					selection_caret = " ",

					-- Keybindings
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<esc>"] = actions.close,
						},
						n = {
							["q"] = actions.close,
						},
					},
				},

				pickers = {
					find_files = {
						hidden = true,
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob",
							"!.git/",
						},
					},
					live_grep = {
						additional_args = function()
							return { "--hidden" }
						end,
					},
				},
			})

			-- Load fzf native extension for better performance
			telescope.load_extension("fzf")
		end,
	},
}
