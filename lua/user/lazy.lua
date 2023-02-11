local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local opts = {
	defaults = {
		lazy = true,
	},
	dev = {
		patterns = { "unendlicherPing" },
	},
	checker = {
		enabled = true,
	},
}

function M.setup()
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	-- set leader key
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "


	require("lazy").setup("plugins", opts)
end

return M
