-- Basic editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "120"
vim.opt.backspace = "indent,eol,start"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.undofile = true
vim.opt.clipboard:append("unnamed")
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.cmdheight = 2
vim.opt.compatible = false
vim.opt.autoread = true
vim.opt.signcolumn = "yes"

-- Terminal colors
vim.opt.termguicolors = true
vim.env.TERM = vim.env.TERM or "xterm-256color"

-- Redirect temp files
vim.opt.undodir = vim.fn.expand("~/.nvim/undodir")
vim.opt.backupdir = vim.fn.expand("~/.nvim/backupdir")
vim.opt.directory = vim.fn.expand("~/.nvim/directory")

-- Search settings
vim.opt.hlsearch = true
vim.opt.showmatch = true

-- History
vim.opt.hidden = true
vim.opt.history = 100

-- Indentation
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Statusline
vim.opt.laststatus = 2
vim.opt.showmode = false

-- Coc-related settings (migrated to native LSP but keeping these for compatibility)
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.shortmess:append("c")

-- Python version
vim.g.pyxversion = 3

-- Terminal color palette
vim.g.terminal_color_0 = "#4e4e4e"
vim.g.terminal_color_1 = "#d68787"
vim.g.terminal_color_2 = "#5f865f"
vim.g.terminal_color_3 = "#d8af5f"
vim.g.terminal_color_4 = "#85add4"
vim.g.terminal_color_5 = "#d7afaf"
vim.g.terminal_color_6 = "#87afaf"
vim.g.terminal_color_7 = "#d0d0d0"
vim.g.terminal_color_8 = "#626262"
vim.g.terminal_color_9 = "#d75f87"
vim.g.terminal_color_10 = "#87af87"
vim.g.terminal_color_11 = "#ffd787"
vim.g.terminal_color_12 = "#add4fb"
vim.g.terminal_color_13 = "#ffafaf"
vim.g.terminal_color_14 = "#87d7d7"
vim.g.terminal_color_15 = "#e4e4e4"

-- Filetype and syntax
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
