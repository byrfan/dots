
vim.lsp.config.asm_lsp = {
    cmd = "asm-lsp",
    filetypes = {"asm", "s", "S"}
}

-- C/C++ {{{
vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "-j=" .. 2,
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
  root_markers = {
    "CMakeLists.txt",
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
    vim.uv.cwd(),
  },
}
-- }}}

vim.o.updatetime = 250

vim.cmd([[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })
]])

vim.lsp.enable("clangd")
vim.lsp.enable('lua_ls')
vim.lsp.enable('asm_lsp')
vim.lsp.enable('pyright')
vim.lsp.enable('biome')
vim.lsp.enable('html-lsp')
vim.lsp.enable('css-lsp')
vim.lsp.enable('ts_ls')
-- to do 
vim.keymap.set('n', '<c-x>', ':lua vim.diagnostic.setloclist()<CR>')

