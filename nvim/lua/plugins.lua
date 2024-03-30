return require("lazy").setup({
	-- completion
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp",
	  dependencies = {'tzachar/cmp-ai'}
	},
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "mfussenegger/nvim-dap" },
	{ 'zbirenbaum/copilot.lua' },
	{
		'zbirenbaum/copilot-cmp',
		config = function()
			require("copilot_cmp").setup()
		end
	},
	{ 'mattn/emmet-vim' },

	-- navigation
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

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
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

	-- utility
	{ 'frazrepo/vim-rainbow' },
	{ 'tpope/vim-fugitive' },
	{ 'tpope/vim-obsession' },
	{
		"gennaro-tedesco/nvim-jqx",
		ft = { "json", "yaml" },
	},
	{
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
			telescope = {},                               -- passed to the telescope picker
			filetypes = {
				-- extends the filetype to docs mappings used by the `DevdocsOpenCurrent` command, the version doesn't have to be specified
				-- scss = "sass",
				-- javascript = { "node", "javascript" }
			},
			float_win = { -- passed to nvim_open_win(), see :h api-floatwin
				relative = "editor",
				height = 25,
				width = 100,
				border = "rounded",
			},
			wrap = false,   -- text wrap, only applies to floating window
			previewer_cmd = "/usr/bin/glow",
			cmd_args = {},  -- example using glow: { "-s", "dark", "-w", "80" }
			cmd_ignore = {}, -- ignore cmd rendering for the listed docs
			picker_cmd = true, -- use cmd previewer in picker preview
			picker_cmd_args = { "-s", "dark", "-w", "50" },
			mappings = {    -- keymaps for the doc buffer
				open_in_browser = ""
			},
			ensure_installed = {
				"dart-2",
				"go",
				"i3",
				"node",
				"jsdoc",
				"ocaml",
				"sqlite",
				"fish-3.7",
				"jekyll-4",
			},
			after_open = function(bufnr) end, -- callback that runs after the Devdocs window is opened. Devdocs buffer ID will be passed in
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require('tree-sitter.install').update({ with_sync = true })()
		end
	},
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
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
})

