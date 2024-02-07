print("Loading go ftplugin")

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local format = require("go.format")
		format.goimport()
		format.gofmt()
	end,
	group = format_sync_grp,
})
