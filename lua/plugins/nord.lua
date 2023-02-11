local M = {
	"shaunsingh/nord.nvim",
	lazy = false,
	priority = 1000,
	enabled = true,
}

function M.config()
    vim.g.nord_contrast = true
    vim.g.nord_borders = true
    vim.g.nord_disable_background = false
    vim.g.nord_cursorline_transparent = false
    vim.g.nord_enable_sidebar_background = false
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false

    -- Load the colorscheme
    require('nord').set()
end

return M
