local M = {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	priority = 999,
}

M.dependencies = {
	"nvim-tree/nvim-web-devicons",
}

M.config = {
	options = {
		theme = "tokyonight",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "filetype" },
		lualine_y = { },
		lualine_z = { "location" }
	},
}

return M
