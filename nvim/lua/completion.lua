local cmp = require("cmp")
local luasnip = require("luasnip")

require("cmp_ai.config"):setup({
  max_lines = 100,
  provider = 'Ollama',
  provider_options = {
    model = 'wizardcoder:latest',
  },
  notify = true,
  notify_callback = function(msg)
    vim.notify(msg)
  end,
  run_on_every_keystroke = true,
  ignored_file_types = {
    -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true
  },
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
		-- { name = 'cmp_ai' },
		{ name = "luasnip" },
		{ name = "codeium" },
		{ name = "luasnip" },
		-- { name = 'cmp_ai' },
	}, {
		{ name = "buffer" },
	}),
})

-- local cmp_ai = require('cmp_ai.config')
-- 
-- cmp_ai:setup({
--   max_lines = 100,
--   provider = 'Ollama',
--   provider_options = {
--     model = 'wizardcoder:latest',
--   },
--   notify = true,
--   notify_callback = function(msg)
--     vim.notify(msg)
--   end,
--   run_on_every_keystroke = true,
--   ignored_file_types = {
--     -- default is not to ignore
--     -- uncomment to ignore in lua:
--     -- lua = true
--   },
-- })

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

