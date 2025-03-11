local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

if (os.execute("command -v lua-language-server")) then
	--ch  Setup lua seperately because it needs to be passed in the vim global
	lspconfig.lua_ls.setup({
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT'
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME
						-- Depending on the usage, you might want to add additional paths here.
						-- "${3rd}/luv/library"
						-- "${3rd}/busted/library",
					}
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
					-- library = vim.api.nvim_get_runtime_file("", true)
				}
			})
		end,
		settings = {
			Lua = {}
		}
	})
end

local language_servers = {
	tsc = lspconfig.ts_ls,
	gopls = lspconfig.gopls,
	zls = lspconfig.zls,
	gleam = lspconfig.gleam,
	templ = lspconfig.templ,
	tflint = lspconfig.tflint,
	pyright = lspconfig.pyright,
}

for name, handler in pairs(language_servers) do
	-- only setup language servers which are found in path
	if os.execute(string.format('command -v %s', name)) then
		handler.setup({ capabilities = capabilities })
	end
end

if (os.execute("command -v jedi-language-server")) then
	lspconfig.jedi_language_server.setup({ capabilities = capabilities })

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
		capabilities = {
			experimental = {
				serverStatusNotification = true,
			},
			capabilities,
		},
		settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = true;
				}
			},
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

if (os.execute("command -v gleam")) then
	lspconfig.gleam.setup({})
end

-- if (os.execute("command -v elixir-ls")) then
-- 	lspconfig.elixirls.setup({
-- 		cmd = { "elixir-ls" }
-- 	})
-- end
--
if (os.execute("command -v kotlin-language-server")) then
	lspconfig.kotlin_language_server.setup({
		capabilities = capabilities,
	})
end

if (os.execute("command -v jedi-langauge-server")) then
	lspconfig.jedi_language_server.setup({
		capabilities = capabilities,
		filetypes = { "python", "xonsh" },
	})
end
