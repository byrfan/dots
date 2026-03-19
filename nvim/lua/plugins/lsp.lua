return {
  -- 1. Mason for managing binaries
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "clangd", "lua-language-server", "asm-lsp", "pyright", "rust-analyzer" }
    },
  },

  -- 2. LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Define configurations for your servers
      vim.lsp.config.asm_lsp = {
        cmd = { "asm-lsp" },
        filetypes = { "asm", "s", "S" },
      }

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

      vim.lsp.config.lua_ls = { cmd = { "lua-language-server" }, filetypes = { "lua" } }
      vim.lsp.config.pyright = { cmd = { "pyright-langserver", "--stdio" }, filetypes = { "python" } }

      -- Enable the servers
      local servers = { "clangd", "lua_ls", "asm_lsp", "pyright", "rust-analyzer" }
      for _, name in ipairs(servers) do
        if vim.lsp.config[name] then
          vim.lsp.enable(name)
        else
          print("Warning: No configuration found for " .. name)
        end
      end

      -- Global Keybindings via LspAttach
-- Global Keybindings via LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- "gd" for Go to Definition (Standard convention)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    
    -- "K" for Hover (Standard convention)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    
    -- "gr" for Go to References
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    
    -- "<leader>rn" for Rename
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    -- "<leader>ca" for Code Actions
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- "<leader>d" for Diagnostics (replaces your <C-x>)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, opts)
  end,
})

      -- Diagnostic hover settings
      vim.o.updatetime = 250
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, { focus = false })
        end,
      })
    end,
  },

  -- 3. Completion Engine (keep this from previous step)
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets"},
    config = function()
      local cmp = require("cmp")
      local has_luasnip, luasnip = pcall(require, "luasnip")
      cmp.setup({

        sources = { { name = "nvim_lsp" } },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
        }),
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        }
      })

      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
