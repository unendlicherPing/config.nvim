local M = {}

function M.setup()
	local set = vim.opt
	local let = vim.g

	-- set leader key
	let.mapleader = " "
	let.maplocalleader = " "

	-- show hybride line numbers
	set.number = true
	set.relativenumber = true
end

return M
