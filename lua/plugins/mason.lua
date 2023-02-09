local M = {
    "williamboman/mason.nvim",
    event = "VeryLazy",
}

M.dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
}

local function on_attach() end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

function M.config()
    require("mason").setup()
    require("mason-lspconfig").setup({ automatic_installation = true })

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    local nvim_lsp = require("lspconfig")

    local function make_opts(settings)
        return {
            lsp_flags = lsp_flags,
            on_attach = on_attach,
            settings = settings,
        }
    end

    nvim_lsp.clangd.setup(make_opts({}))
    nvim_lsp.dockerls.setup(make_opts({}))
    nvim_lsp.vimls.setup(make_opts({}))
    nvim_lsp.marksman.setup(make_opts({}))
    nvim_lsp.rust_analyzer.setup(make_opts({
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
            },
        },
    }))

    nvim_lsp.sumneko_lua.setup(make_opts({
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    }))
end

return M
