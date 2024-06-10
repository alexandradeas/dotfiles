vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.g.rainbow_active = 1
vim.cmd.colorscheme("catppuccin")

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

vim.cmd("highlight MatchParen cterm=none ctermbg=none ctermfg=none")
