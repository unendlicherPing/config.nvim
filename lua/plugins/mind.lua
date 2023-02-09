local M = {
	'phaazon/mind.nvim',
	config = true,
}

M.cmd = {
	"MindOpenMain",
	"MindOpenProject",
	"MindOpenSmartProject",
	"MindReloadState",
	"MindClose",
}

M.dependencies = {
	"nvim-lua/plenary.nvim",
}

return M
