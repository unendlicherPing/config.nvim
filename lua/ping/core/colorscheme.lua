-- set colorscheme to nord with protected call
-- in case it isn't installed
local theme_status, _ = pcall(vim.cmd, "colorscheme nord")
if not theme_status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end
