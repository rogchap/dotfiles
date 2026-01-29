-- OpenCode.nvim + Snacks.nvim configuration
return {
	-- Snacks.nvim (dependency for opencode)
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("snacks").setup({
				input = { enabled = true },
				picker = { enabled = true },
				terminal = { enabled = true },
				-- Disable other snacks features by default
				bigfile = { enabled = false },
				notifier = { enabled = false },
				quickfile = { enabled = false },
				statuscolumn = { enabled = false },
				words = { enabled = false },
			})
		end,
	},

	-- OpenCode.nvim
	{
		"NickvanDyke/opencode.nvim",
		dependencies = { "snacks.nvim" },
		lazy = false,
		config = function()
			-- Provider configuration
			vim.g.opencode_opts = {
				provider = {
					enabled = "tmux",
					tmux = {
						options = "-h -p 30",
						args = "--mode plan", -- Default to plan mode
					},
				},
			}

			-- Core actions
			vim.keymap.set({ "n", "x" }, "<Leader>ca", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })

			vim.keymap.set({ "n", "x" }, "<Leader>cs", function()
				require("opencode").select()
			end, { desc = "Select opencode action" })

			vim.keymap.set({ "n", "t" }, "<Leader>cc", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })

			-- Quick prompts
			vim.keymap.set({ "n", "x" }, "<Leader>ce", function()
				require("opencode").prompt("explain")
			end, { desc = "Explain with opencode" })

			vim.keymap.set({ "n", "x" }, "<Leader>cr", function()
				require("opencode").prompt("review")
			end, { desc = "Review with opencode" })

			vim.keymap.set("n", "<Leader>cf", function()
				require("opencode").prompt("fix")
			end, { desc = "Fix with opencode" })

			vim.keymap.set({ "n", "x" }, "<Leader>cd", function()
				require("opencode").prompt("document")
			end, { desc = "Document with opencode" })

			vim.keymap.set({ "n", "x" }, "<Leader>co", function()
				require("opencode").prompt("optimize")
			end, { desc = "Optimize with opencode" })

			-- Operators
			vim.keymap.set("n", "go", function()
				return require("opencode").operator("@this ")
			end, { desc = "Add range to opencode", expr = true })

			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { desc = "Add line to opencode", expr = true })

			-- Session management
			vim.keymap.set("n", "<Leader>cn", function()
				require("opencode").command("session.new")
			end, { desc = "New opencode session" })

			vim.keymap.set("n", "<Leader>ci", function()
				require("opencode").command("session.interrupt")
			end, { desc = "Interrupt opencode session" })

			vim.keymap.set("n", "<Leader>cl", function()
				require("opencode").command("session.select")
			end, { desc = "Select opencode session" })

			-- Navigation
			vim.keymap.set("n", "<Leader>cu", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "Scroll opencode up" })

			vim.keymap.set("n", "<Leader>cj", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "Scroll opencode down" })

			-- Auto-open opencode command
			vim.api.nvim_create_user_command("Vide", function()
				require("opencode").toggle()
			end, { desc = "Open nvim with opencode" })
		end,
	},
}
