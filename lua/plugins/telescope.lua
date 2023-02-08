local M = { "nvim-telescope/telescope.nvim", branch = "0.1.x" }

M.dependencies = {
	"nvim-lua/plenary.nvim",
}

M.cmd = {
	"Telescope",
}

M.keys = {
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find in Files" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
}

M.opts = {
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
}

return M
