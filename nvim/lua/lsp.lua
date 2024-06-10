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
	dart = lspconfig.dartls,
	nil_ls = lspconfig.nil_ls,
	tsc = lspconfig.tsserver,
	gopls = lspconfig.gopls,
	zls = lspconfig.zls,
	gleam = lspconfig.gleam,
}

lspconfig.pylsp.setup({
	settings = {
		pylsp = {
			plugins = {
				-- formatter
				black = { enabled = true },
				autopep8 = { enabled = true },
				yapf = { enabled = true },
				-- linter
				pylint = { enabled = true },
				pyflakes = { enabled = true },
				pycodestyle = { enabled = true },
				-- typechecker
				pylsp_mypy = { enabled = true },
				-- auto-completion
				jedi_completion = { enabled = true },
				-- import sorting
				pyls_isort = { enabled = true },
			},
		},
	},
})

for name, handler in pairs(language_servers) do
	-- only setup language servers which are found in path
	if os.execute(string.format('command -v %s', name)) then
		handler.setup({ capabilities = capabilities })
	end
end

if (os.execute("command -v rust-analyzer")) then
	lspconfig.rust_analyzer.setup({
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {},
		},
	})
end

if (os.execute("command -v graphql-lsp")) then
	lspconfig.graphql.setup({ capabilities = capabilities })
end

if (os.execute("command -v ruby-lsp")) then
	lspconfig.ruby_lsp.setup({ capabilities = capabilities })
end
