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

require("lazy").setup({
	-- { "willuiamboman/mason.nvim" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		}
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},

	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},

	{ "tpope/vim-surround" },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},

	{ "nvim-focus/focus.nvim", version = "*" },

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	{ "cheap-glitch/vim-v" },

	{ "ziglang/zig-mode" },

	{ "fatih/vim-go" },

	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {},
	-- },

	{ "preservim/tagbar" },

	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
		},
		config = function()
			-- get neotest namespace
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
								diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " ")
								:gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			require("neotest").setup({
				adapters = {
					require("neotest-go")({
						experimental = {
							test_table = true,
						},
						args = { "-count=1", "-timeout=60s" }
					}),
				},
			})
		end,
	},

	-- { 'codota/tabnine-nvim', build = "./dl_binaries.sh" },
	{ 'github/copilot.vim' },
	{ 'tpope/vim-fugitive' },

	{ 'tpope/vim-obsession' },

	{ 'hashivim/vim-terraform' },

	{ 'mattn/emmet-vim' },
})

-- Options

vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.cmd [[colorscheme slate]]


-- Relative line numbers for focused buffer, otherwise absolute line numbers
local NumberToggle = vim.api.nvim_create_augroup("NumberToggle", {})
-- vim.api.nvim_create_autocmd("", { group = NumberToggle })
vim.api.nvim_create_autocmd("BufEnter,FocusGained,InsertLeave", {
	group = NumberToggle,
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = true
	end
})
vim.api.nvim_create_autocmd("BufLeave,FocusLost,InsertLeave", {
	group = NumberToggle,
	pattern = "*",
	callback = function()
		vim.opt.relativenumber = false
	end
})

-- setup TabNine
-- require('tabnine').setup({
-- 	disable_auto_comment = true,
-- 	accept_keymap = "<Tab>",
-- 	dismiss_keymap = "<C-]>",
-- 	debounce_ms = 800,
-- 	suggestion_color = { gui = "#808080", cterm = 244 },
-- 	exclude_filetypes = { "TelescopePrompt" },
-- 	log_file_path = nil, -- absolute path to Tabnine log file
-- })

-- diagnostics
vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)

-- LSP
local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	lsp.buffer_autoformat()
end)

-- configure LuaLS for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- load telescope extensions
local telescope = require("telescope")
telescope.load_extension("harpoon")
telescope.load_extension("file_browser")

-- require("focus").setup()

-- keybindings
local wk = require("which-key")

-- register leader bindings
wk.register({
	g = {
		name = "Goto",
		d = { function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
			"Goto Definition" },
		D = { vim.lsp.buf.declaration, "Goto Declaration" },
		h = { vim.lsp.buf.hover, "Hover" },
		I = { function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
			"Goto Implementation" },
		k = { vim.lsp.buf.signature_help, "Signature Help" },
		r = { "<cmd>Telescope lsp_references<cr>", "Goto References" },
		y = { function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
			"Goto T[y]pe Definition" },
	},
}, { prefix = "", mode = "n" })

wk.register({
	k = { vim.lsp.buf.signature_help, "Signature Help" },
}, { mode = "i", prefix = "<Ctrl>" })
wk.register({
	f = {
		name = "Find",
		f = { "<cmd>Telescope find_files<cr>", "File" },
		g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
		b = { "<cmd>Telescope buffers<cr>", "buffers" },
		h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
		e = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", "Explore relative" },
	},

	b = {
		name = "Buffers",
		m = { "<cmd>:lua require(\"harpoon.mark\").add_file()<cr>", "Mark" },
		s = { "<cmd>:lua require(\"harpoon.ui\").toggle_quick_menu()<cr>", "Toggle Buffer Stack" },
		n = { "<cmd>:lua require(\"harpoon.ui\").nav_next()<cr>", "Next", },
		p = { "<cmd>:lua require(\"harpoon.ui\").nav_prev()<cr>", "Previous" },
	},

	c = {
		name = "Code",
		f = { vim.lsp.buf.format, "Format" },
		a = { vim.lsp.buf.code_action, "Action" },
	},

	t = {
		name = "Toggle",
		tb = { "<cmd>TagbarToggle<cr>", "Tagbar" },
	},

}, { prefix = "<leader>" })
