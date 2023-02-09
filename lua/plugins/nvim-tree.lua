local M = {
	"nvim-tree/nvim-tree.lua",
	config = true,
}

M.dependencies = {
    "nvim-tree/nvim-web-devicons",
}

M.cmd = {
	"NvimTreeToggle",
	"NvimTreeFocus",
	"NvimTreeFindFile",
	"NvimTreeCollapse",
}


M.keys = {
	{ "<leader>ft", vim.cmd.NvimTreeToggle, desc = "NvimTree" },
}

return M
