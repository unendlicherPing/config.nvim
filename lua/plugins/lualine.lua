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
		disabled_filetypes = {
			statusline = { "NvimTree" },
		},
	},

	sections = {},
	inactive_sections = {},

	tabline = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "filetype" },
		lualine_y = { { "tabs", mode = 1 } },
		lualine_z = { "location" }
	},
}

return M
