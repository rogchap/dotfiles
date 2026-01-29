-- LSP configuration (replaces coc.nvim)
return {
	-- LSP installer
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
		end,
	},

	-- Mason LSP integration
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				-- Auto-install these LSP servers
				ensure_installed = {
					"gopls",
					"jsonls",
					"buf_ls",
					"rust_analyzer",
					"lua_ls",
				},
				automatic_installation = true,
			})
		end,
	},

	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-lspconfig.nvim", "cmp-nvim-lsp" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Diagnostic configuration with custom signs
			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "!",
						[vim.diagnostic.severity.HINT] = "?",
						[vim.diagnostic.severity.INFO] = "?",
					},
				},
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
				},
			})

			-- LSP keybindings (replaces coc.nvim mappings)
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }

				-- Main LSP keybindings
				vim.keymap.set("n", "<leader><cr>", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				-- Format on save
				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end

			-- Get capabilities with nvim-cmp
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Go LSP (with settings from coc-settings.json)
			vim.lsp.config("gopls", {
				cmd = { "gopls" },
				root_markers = { "go.mod", "go.work", ".git" },
				capabilities = capabilities,
				settings = {
					gopls = {
						gofumpt = true,
						staticcheck = true,
						usePlaceholders = true,
						completeUnimported = true,
						matcher = "Fuzzy",
						analyses = {
							unusedparams = true,
						},
					},
				},
			})

			-- JSON LSP
			vim.lsp.config("jsonls", {
				cmd = { "vscode-json-language-server", "--stdio" },
				root_markers = { ".git" },
				capabilities = capabilities,
			})

			-- Protocol Buffers LSP
			vim.lsp.config("buf_ls", {
				cmd = { "bufls", "serve" },
				root_markers = { "buf.yaml", "buf.work.yaml", ".git" },
				capabilities = capabilities,
			})

			-- Lua LSP (for editing your config!)
			vim.lsp.config("lua_ls", {
				cmd = { "lua-language-server" },
				root_markers = { ".git", ".luarc.json", ".luarc.jsonc" },
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			-- Enable LSP servers with on_attach callback
			local servers = { "gopls", "jsonls", "buf_ls", "lua_ls" }
			for _, server in ipairs(servers) do
				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if client and client.name == server then
							on_attach(client, args.buf)
						end
					end,
				})
				vim.lsp.enable(server)
			end

			-- Configure hover window
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})
		end,
	},

	-- Rust support (replaces rust.vim)
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					on_attach = function(client, bufnr)
						local opts = { buffer = bufnr, silent = true }
						vim.keymap.set("n", "<leader><cr>", vim.lsp.buf.definition, opts)
						vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
						vim.keymap.set({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, opts)
						vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					end,
				},
			}
		end,
	},

	-- Flutter/Dart support (replaces dart-vim-plugin)
	{
		"akinsho/flutter-tools.nvim",
		ft = { "dart" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("flutter-tools").setup({
				lsp = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					on_attach = function(client, bufnr)
						local opts = { buffer = bufnr, silent = true }
						vim.keymap.set("n", "<leader><cr>", vim.lsp.buf.definition, opts)
						vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
						vim.keymap.set({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, opts)
						vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					end,
					settings = {
						dart = {
							lineLength = 120,
						},
					},
				},
				dev_log = {
					enabled = true,
					open_cmd = "botright 10split",
				},
			})

			-- Flutter commands (replaces :CocCommand flutter.*)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "dart",
				callback = function()
					vim.keymap.set("n", "<leader>r", "<cmd>FlutterRun<cr>", { buffer = true, desc = "Flutter run" })
					vim.keymap.set("n", "<leader>q", "<cmd>FlutterQuit<cr>", { buffer = true, desc = "Flutter quit" })
				end,
			})
		end,
	},
}
