local M = {}

function M.setup()
	local set = vim.opt
	local let = vim.g

	-- show hybride line numbers
	set.number = true
	set.relativenumber = true

	-- remove statusline
	set.showmode = false
        set.ruler = false
        set.laststatus = 0
        set.showcmd = false
end

return M
