-- Load plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy if it doesn"t exist
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = "," -- Leader must be mapped before calling lazy

require("plugins")
require("opts")
require("ui")
require("completion")
require("lsp")
require("keybindings")

-- load telescope extensions
local telescope = require("telescope")
telescope.load_extension("harpoon")
telescope.load_extension("file_browser")

require('refactoring').setup()
