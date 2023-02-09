local M = {}

function M.setup()
	local set = vim.opt
	local let = vim.g

	-- show hybride line numbers
	set.number = true
	set.relativenumber = true

	-- set tab size
	set.tabstop = 4
	set.shiftwidth = 4
	set.expandtab = true
    set.autoindent = true

	-- remove statusline
	set.showmode = false
        set.ruler = false
        set.laststatus = 0
        set.showcmd = false

	-- enable folding
	set.foldmethod = "expr"
	set.foldexpr = "nvim_treesitter#foldexpr()"
	set.foldenable = false -- Disable folding at startup.
end

return M
