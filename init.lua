local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
	impatient.enable_profile()
end

for _, source in ipairs({
	"ping.plugin-setup",
	"ping.core.options",
	"ping.core.colorscheme",
	"ping.core.keymap",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
	end
end

if vim.fn.has("nvim-0.8") ~= 1 or vim.version().prerelease then
	error("Unsupported Neovim Version! Please check the requirements")
end
