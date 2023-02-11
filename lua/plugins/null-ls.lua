local M = {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
}

M.dependencies = {
    "nvim-lua/plenary.nvim"
}

function M.config()
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.diagnostics.commitlint,
        }
    })
end

return M
