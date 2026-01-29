-- ============================================================================
-- Neovim Configuration (Lua)
-- Migrated from init.vim to modern Lua-based configuration
-- ============================================================================

-- Set leader key before any plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration
require("config")

-- Load plugins (lazy.nvim)
require("plugins")
