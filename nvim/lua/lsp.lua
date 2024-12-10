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
	tsc = lspconfig.ts_ls,
	gopls = lspconfig.gopls,
	zls = lspconfig.zls,
	gleam = lspconfig.gleam,
	templ = lspconfig.templ,
	tflint = lspconfig.tflint,
}

for name, handler in pairs(language_servers) do
	-- only setup language servers which are found in path
	if os.execute(string.format('command -v %s', name)) then
		handler.setup({ capabilities = capabilities })
	end
end

if (os.execute("command -v dart")) then
	lspconfig.dartls.setup({
		capabilities = capabilities,
		settings = {
			dart = {
				codelens = {
					enabled = true,
				},
				lineLength = 120
			}
		}
	})
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

if (os.execute("command -c htmx-lsp")) then
	lspconfig.htmx.setup({
		capabilities = capabilities,
		filetypes = { "html", "templ" },
	})
end

if (os.execute("command -v terraform-ls")) then
	lspconfig.terraformls.setup({
		capabilities = capabilities,
	})
end

if (os.execute("command -v svelte-language-server")) then
	lspconfig.svelte.setup({})
end
