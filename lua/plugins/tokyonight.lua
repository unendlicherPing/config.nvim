local M = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	enabled = true,
}

function M.config()
	require("tokyonight").setup()
	require("tokyonight").load()
end

return M
