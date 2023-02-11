local M = {}

function M.setup()
	vim.keymap.set("i", "jk", "<esc>", { desc = "escape" })
	vim.keymap.set("t", "jk", "<c-\\><c-n>", { desc = "escape terminal mode" })
end

return M
