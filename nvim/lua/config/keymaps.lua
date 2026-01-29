-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Previous file
vim.keymap.set("n", "<Leader><Leader>", ":e#<CR>", { desc = "Previous file" })

-- Clear search highlight (escape key handling)
vim.keymap.set("n", "<esc>", ":noh<return><esc>", { silent = true })
vim.keymap.set("n", "<esc>^[", "<esc>^[", { silent = true })

-- Telescope fuzzy finding (replaces FZF)
vim.keymap.set("n", "<Leader>t", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<Leader>f", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })

-- Lazygit in tmux popup
local function open_lazygit()
	vim.fn.system("tmux display-popup -d '#{pane_current_path}' -w90% -h90% -E lazygit")
end
vim.keymap.set("n", "<Leader>g", open_lazygit, { desc = "Lazygit" })

-- LSP keybindings (these will be set in lsp.lua on_attach, but defining global fallbacks)
-- Actual LSP bindings are buffer-local and set when LSP attaches
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })

-- Note: The following LSP keybindings are set in lua/plugins/lsp.lua on_attach:
-- <leader><cr> - Go to definition
-- gy - Type definition
-- gi - Implementation
-- gr - References
-- <leader>rn - Rename
-- <leader>a - Code actions
