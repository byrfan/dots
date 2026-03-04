-- 1. Define configurations for your servers
-- Assembly
vim.lsp.config.asm_lsp = {
    cmd = { "asm-lsp" },
    filetypes = { "asm", "s", "S" },
}

-- C/C++
vim.lsp.config.clangd = {
    cmd = {
        "clangd",
        "-j=2",
        "--background-index",
        "--clang-tidy",
        "--inlay-hints",
        "--fallback-style=llvm",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
        "--pch-storage=memory",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_markers = { "CMakeLists.txt", ".clangd", ".git" },
}

-- You MUST define the others if you aren't using nvim-lspconfig
vim.lsp.config.lua_ls = { cmd = { "lua-language-server" }, filetypes = { "lua" } }
vim.lsp.config.pyright = { cmd = { "pyright-langserver", "--stdio" }, filetypes = { "python" } }

-- 2. Global Keybindings via LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local opts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set('n', '<C-d>', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<C-x>', vim.diagnostic.setloclist, opts)
    end,
})

-- 3. Enable the servers
local servers = { "clangd", "lua_ls", "asm_lsp", "pyright" }

for _, name in ipairs(servers) do
    if vim.lsp.config[name] then
        vim.lsp.enable(name)
    else
        print("Warning: No configuration found for " .. name)
    end
end

-- Diagnostic hover settings
vim.o.updatetime = 250
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
    end,
})
