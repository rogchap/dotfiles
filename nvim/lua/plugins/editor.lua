-- Editor enhancement plugins
return {
	-- Commenting (replaces tcomment_vim)
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gc", mode = { "n", "x" }, desc = "Toggle comment" },
			{ "gb", mode = { "n", "x" }, desc = "Toggle block comment" },
		},
		config = function()
			require("Comment").setup()
		end,
	},

	-- Tmux navigation (keep existing)
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	-- Remember last position (replaces vim-lastplace)
	{
		"ethanholz/nvim-lastplace",
		lazy = false,
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
		end,
	},

	-- Auto-close pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				check_ts = true,
				disable_filetype = { "TelescopePrompt", "vim" },
			})

			-- Integrate with nvim-cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = {
					char = "│",
				},
				scope = {
					enabled = false,
				},
			})
		end,
	},
}
