return require("lazy").setup({
	-- completion
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "tzachar/cmp-ai" }
	},
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "mfussenegger/nvim-dap" },
	{ 'mattn/emmet-vim' },
	{ "tzachar/cmp-ai" },
	-- { "maxwell-bland/cmp-ai" },

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

	-- languages/platforms
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
		event = { "CmdlineEnter" },
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
	{ 'meatballs/vim-xonsh' },
	{ 'averms/black-nvim' },
	{
		'zadirion/Unreal.nvim',
		dependencies = {
			"tpope/vim-dispatch",
		},
	},
	{
		'windwp/nvim-ts-autotag',
		lazy = false,
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = true,
				},
			})
		end,
	},

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
	{ "ellisonleao/glow.nvim",  config = true, cmd = "Glow" },
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
			model = "qwen2.5:latest",
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
	{ 'sindrets/diffview.nvim' },
	{ 'lewis6991/gitsigns.nvim' },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"sidlatau/neotest-dart"
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-dart") {
						command = "fvm flutter",
						use_lsp = true,
					},
				}
			})
		end,
	},
	{
		"sidlatau/neotest-dart",
		dependencies = {
			"nvim-neotest/neotest",
		},
		lazy = false,
		custom_test_method_names = { 'blocTest' },
	},
	{
		"nvim-neotest/neotest-go",
		dependencies = {
			"nvim-neotest/neotest",
		},
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			require("neotest").setup({
				adapters = {
					require("neotest-go") {
						experimental = {
							test_table = true,
						},
						args = { "-count=1", "-timeout=60s", "-race" },
					},
				},
			})
		end,
	},

	-- UI
	{ "EdenEast/nightfox.nvim",     name = "nightfox" },
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				vim.cmd("colorscheme nightfox")
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				vim.cmd("colorscheme dayfox")
			end,
		},
		fallback = "dark",
	},

	{ "nvim-tree/nvim-web-devicons" },
	{ "echasnovski/mini.icons" },
	{ "David-Kunz/gen.nvim" },
})
