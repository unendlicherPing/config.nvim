local M = {
    "williamboman/mason.nvim",
    event = "VeryLazy",
}

M.dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
}

local function on_attach(_, buffer_number)
    vim.api.nvim_buf_set_option(buffer_number, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Diagnostic hint", buffer = buffer_number })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Goto declaration", buffer = buffer_number })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Goto definition", buffer = buffer_number })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "hove", buffer = buffer_number })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Goto implementation", buffer = buffer_number })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Signature help", buffer = buffer_number })
    vim.keymap.set('n', "<leader>cD", vim.lsp.buf.type_definition,
        { desc = "Goto type definition", buffer = buffer_number })
    vim.keymap.set('n', '<space>cf', vim.lsp.buf.rename, { desc = "Rename", buffer = buffer_number })
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { desc = "Action", buffer = buffer_number })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Goto references", buffer = buffer_number })
    vim.keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end,
        { desc = "Format", buffer = buffer_number })
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

function M.config()
    require("mason").setup()
    require("mason-lspconfig").setup({ automatic_installation = true })

    -- TODO: fix this vim.cmd.MasonInstall("commitlint")

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/?.lua")

    local nvim_lsp = require("lspconfig")

    local function make_opts(settings)
        return {
            lsp_flags = lsp_flags,
            on_attach = on_attach,
            settings = settings or {},
        }
    end

    nvim_lsp.clangd.setup(make_opts())
    -- nvim_lsp.ccls.setup(make_opts({})) removed because mason does not support ccls
    nvim_lsp.neocmake.setup(make_opts())
    nvim_lsp.dockerls.setup(make_opts())
    nvim_lsp.vimls.setup(make_opts())
    nvim_lsp.marksman.setup(make_opts())
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
