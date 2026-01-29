-- Relative line number toggling
local numbertoggle = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	group = numbertoggle,
	pattern = "*",
	callback = function()
		if vim.opt.number:get() then
			vim.opt.relativenumber = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	group = numbertoggle,
	pattern = "*",
	callback = function()
		if vim.opt.number:get() then
			vim.opt.relativenumber = false
		end
	end,
})

-- Go: Auto-organize imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
		for _, res in pairs(result or {}) do
			for _, action in pairs(res.result or {}) do
				if action.edit then
					vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
				else
					vim.lsp.buf.execute_command(action.command)
				end
			end
		end
	end,
})

-- CursorHold hover and highlight
local blacklist = { "vim", "help" }

vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		local ft = vim.bo.filetype
		if not vim.tbl_contains(blacklist, ft) then
			-- Silently attempt hover
			pcall(vim.lsp.buf.hover)
		end
	end,
})
