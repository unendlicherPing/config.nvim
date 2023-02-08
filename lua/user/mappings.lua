local M = {}

function M.setup()
	vim.keymap.set("i", "jk", "<esc>", { desc = "escape" })
end

return M
