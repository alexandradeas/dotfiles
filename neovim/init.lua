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
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },

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

	{ "ziglang/zig.vim" },

	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdLineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()'
	},

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
	{ 'zbirenbaum/copilot.lua' },
	{
		'zbirenbaum/copilot-cmp',
		config = function()
			require("copilot_cmp").setup()
		end
	},
	{ 'tpope/vim-fugitive' },

	{ 'tpope/vim-obsession' },

	{ 'hashivim/vim-terraform' },

	{ 'mattn/emmet-vim' },

	{ 'frazrepo/vim-rainbow' },

	{ 'HiPhish/gradle.nvim' },

	{ 'udalov/kotlin-vim' },

	{ 'dart-lang/dart-vim-plugin' },

	{ 'thosakwe/vim-flutter' },
})

-- Options

vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.g.rainbow_active = 1


-- Relative line numbers for focused buffer, otherwise absolute line numbers
local NumberToggle = vim.api.nvim_create_augroup("NumberToggle", {})
-- vim.api.nvim_create_autocmd("", { group = NumberToggle })

for _, event_name in ipairs({ "BufEnter", "FocusGained", "InsertLeave" }) do
	vim.api.nvim_create_autocmd(event_name, {
		group = NumberToggle,
		pattern = "*",
		callback = function()
			vim.opt.relativenumber = true
		end
	})
end
for _, event_name in ipairs({ "BufLeave", "FocusLost", "InsertEnter" }) do
	vim.api.nvim_create_autocmd(event_name, {
		group = NumberToggle,
		pattern = "*",
		callback = function()
			vim.opt.relativenumber = false
			vim.opt.number = true
		end
	})
end

-- load telescope extensions
local telescope = require("telescope")
telescope.load_extension("harpoon")
telescope.load_extension("file_browser")

local cmp = require("cmp")
local luasnip = require("luasnip")

-- disable copilot default suggestions as these will be handled by cmp instead
require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "copilot" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- set up lspconfig
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

-- Setup lua seperately because it needs to be passed in the vim global
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})

local language_servers = {
	dartls = lspconfig.dartls,
	nil_ls = lspconfig.nil_ls,
	tsc = lspconfig.tsserver,
	gopls = lspconfig.gopls,
	rust_analyzer = lspconfig.rust_analyzer,
	pyright = lspconfig.pyright,
	zls = lspconfig.zls,
}



for name, handler in pairs(language_servers) do
	-- only setup language servers which are found in path
	if os.execute(string.format('command -v %s', name)) then
		handler.setup({ capabilities = capabilities })
	end
end

-- keybindings
local wk = require("which-key")

local trouble = require("trouble")

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
		l = { function() vim.lsp.buf.open_float() end, "Open float" },
	},
	K = { function() vim.lsp.buf.hover() end, "Do Hover" },
	r = {
		name = "Refactor",
		n = { vim.lsp.buf.rename, "Rename" },
	},
}, { prefix = "", mode = "n" })

wk.register({
	c = {
		name = "Code",
		f = { vim.lsp.buf.format, "Format" },
		a = { function()
			if vim.lsp.buf.range_code_action then
				vim.lsp.buf.range_code_action()
			else
				vim.lsp.buf.code_action()
			end
		end, "Action" },
	},
}, { prefix = "<leader>", mode = "x" })

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
		n = {
			function() require("harpoon.ui").get_keymap("nav_next") end,
			"Next",
		},
		p = {
			function() require("harpoon.ui").get_keymap("nav_prev") end,
			"Previous",
		},
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

	x = {
		name = "Diagnostic",
		x = { trouble.toggle, "Trouble" },
		w = { function() trouble.open("workspace_diagnostics") end, "Workspace Diagnostics" },
		d = { function() trouble.open("document_diagnostics") end, "Document Diagnostics" },
		q = { function() trouble.open("quickfix") end, "Quickfix" },
		l = { function() trouble.open("loclist") end, "Loclist" },
	},
}, { prefix = "<leader>" })

vim.cmd [[colorscheme slate]]
