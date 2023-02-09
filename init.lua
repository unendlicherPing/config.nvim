require("user.lazy").setup()
require("user.options").setup()

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("user.mappings").setup()
    end,
})
