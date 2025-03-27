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
		i = { "<cmd>Telescope find_files hidden=true<cr>", "Files (with ignored)" },
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
		name = "Test",
		s = { function() require("neotest").run.run() end, "Single" },
		b = { function() require("neotest").run.run(vim.fn.expand("%")) end, "Run Buffer" },
		d = { function() require("neotest").run.run({ strategy = "dap" }) end, "Debug" },
		h = { function() require("neotest").run.step() end, "Halt" },
		t = {
			name = "Toggle",
			p = { function() require("neotest").output_panel.toggle() end, "Panel" },
			s = { function() require("neotest").summary.toggle() end, "Summary" },
		},
		w = {
			name = "Watch",
			a = { function() require("neotest").watch.toggle() end, "All" },
			b = { function() require("neotest").watch.toggle(vim.fn.expand("%")) end, "Buffer" },
		},
	},

	x = {
		name = "Trouble",
		x = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics " },
		X = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer diagnostics" },
		s = { "<cmd>Trouble symbols toggle<cr>", "Symbols" },
		L = { "<cmd>Trouble loclist toggle<cr>", "Location List" },
		Q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List" },
	},
}, { prefix = "<leader>" })
