local M = {
	"arcticicestudio/nord-vim",
	lazy = false,
	priority = 1000,
	enabled = false,
}

function M.config()
	vim.cmd [[ colorscheme nord ]]
end

return M
