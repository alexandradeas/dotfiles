return require("lazy").setup({
	-- completion
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = { 'tzachar/cmp-ai' }
	},
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "mfussenegger/nvim-dap" },
	{ 'mattn/emmet-vim' },
	-- { "tzarchar/cmp-ai" }, is currerntly not working with ollama
	{ "maxwell-bland/cmp-ai" },
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-plenary/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_chat = true,
				chat_window = {
					relative = "editor",
					position = "50%",
					size = {
						height = "80%",
						width = "80%",
					}
				}
			})
		end,
	},

	-- navigation
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
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

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		tag = "v2.1.0",
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- languages
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
	{ "cheap-glitch/vim-v" },
	{ 'HiPhish/gradle.nvim' },
	{ 'udalov/kotlin-vim' },
	{ 'dart-lang/dart-vim-plugin' },
	{ 'thosakwe/vim-flutter' },
	{ 'hashivim/vim-terraform' },
	{ "jparise/vim-graphql" },
	{ 'gleam-lang/gleam.vim' },
	{ 'joerdav/templ.vim' },
	{ 'evanleck/vim-svelte' },
	{
		'elixir-tools/elixir-tools.nvim',
		version = "v0.17.0",
		event   = { "BufReadPre", "BufNewFile" },
		config  = function()
			local elixir = require("elixir")
			local elixirls = require("elixir.elixirls")

			elixir.setup({
				nextls = { enabled = true },
				elixirls = {
					enabled = true,
					settings = elixirls.settings {
						dialyzerEnabled = true,
						enableTestLenses = true,
					},
					on_attach = function(client, bufnr)
						vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
						vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
						vim.keymap.set("n", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
					end
				},
				projectionist = { enabled = true },
			})
		end
	},
	{ 'elixir-lang/vim-elixir' },
	-- { 'avdgaag/vim-phoenix' },

	-- utility
	{ 'frazrepo/vim-rainbow' },
	{ 'tpope/vim-fugitive' },
	{ 'tpope/vim-obsession' },
	{
		"gennaro-tedesco/nvim-jqx",
		ft = { "json", "yaml" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "elixir", "eex", "heex" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
		run = function()
			require('tree-sitter.install').update({ with_sync = true })()
		end
	},
	{ "ellisonleao/glow.nvim",      config = true,      cmd = "Glow" },
	{
		"ahollister/nota.nvim",
		config = function()
			require("nota").setup({
				global_path = os.getenv("HOME") .. "notes/notes.md",
				scratch_path = os.getenv("HOME") .. "notes/scratch.md",
				local_path = "notes/notes.md",
				vertical_split = true
			})
		end
	},
	{
		"David-Kunz/gen.nvim",
		opts = {
			model = "wizardcoder:latest",
			show_prompt = true,
			show_model = true,
			no_auto_close = true,
			debug = false,
			display_mode = "split",
		},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = false,
		config = function()
			require("refactoring").setup()
		end,
	},

	-- UI
	{ "catppuccin/nvim",            name = "catpuccin", priority = 1000 },
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				vim.cmd("colorscheme catpuccin")
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				vim.cmd("colorscheme catpuccin-latte")
			end,
		},
	},

	{ "nvim-tree/nvim-web-devicons" },
	{ "echasnovski/mini.icons" },
})
