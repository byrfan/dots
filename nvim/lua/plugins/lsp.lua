return {
  -- 1. Mason for managing binaries
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "clangd", "lua-language-server", "asm-lsp", "pyright", "rust_analyzer" }
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    config = function()
        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter")

        -- configure treesitter
        treesitter.setup({ -- enable syntax highlighting
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            -- enable indentation
            indent = { enable = true },

            ensure_installed = {
              "c",
              "go",
              "html",
              "css",
              "markdown",
              "markdown_inline",
              "lua",
              "vim",
              "vimdoc",
              "rust",
              "javascript",
              "json",
              "python",
              "bash",
              "cpp",
            },
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    -- scope_incremental = false,
                    node_decremental = "<C-backspace>",
                },
            },
        })
        -- force start treesitter for all filetypes
        vim.api.nvim_create_autocmd('FileType', {
            pattern = '*',
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
  },
-- NOTE: js,ts,jsx,tsx Auto Close Tags
{
    "windwp/nvim-ts-autotag",
    enabled = true,
    ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
    config = function()
        -- Independent nvim-ts-autotag setup
        require("nvim-ts-autotag").setup({
            opts = {
                enable_close = true,           -- Auto-close tags
                enable_rename = true,          -- Auto-rename pairs
                enable_close_on_slash = false, -- Disable auto-close on trailing `</`
            },
            per_filetype = {
                ["html"] = {
                    enable_close = true, -- Disable auto-closing for HTML
                },
                ["typescriptreact"] = {
                    enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
                },
            },
        })
    end,
},

{
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    telescope = require('telescope').setup({
      extensions = {
        fzf = {}
      }
    })
    
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.9,
            height = 0.95,
            -- This gives the preview 70% of the screen at the TOP
            preview_height = 0.7, 
            -- Puts the prompt at the bottom
            prompt_position = "bottom",
            -- Keeps preview at the top and results in the middle
            mirror = false, 
          },
        },
        -- Use 'descending' so the best match is right above your prompt
        sorting_strategy = "descending", 

        preview = {treesitter = false}
      },
    })

    require('telescope').load_extension('fzf')
      local builtin = require('telescope.builtin')
      -- Find files by name
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
      
      -- Search for text inside files (requires 'ripgrep' installed on your OS)
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
      
      -- Find open buffers
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
  
      -- Look through your help tags
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })

      -- Add this inside your Telescope config function
      vim.keymap.set('n', '<leader>fj', require('telescope.builtin').jumplist, { desc = "View Jumplist" })
    end
  },
  -- 2. LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { 
        "hrsh7th/cmp-nvim-lsp",
    },
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

            -- Lua
      vim.lsp.config.lua_ls = { 
        cmd = { "lua-language-server" }, 
        filetypes = { "lua" },
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }

      -- Python
      vim.lsp.config.pyright = { 
        cmd = { "pyright-langserver", "--stdio" }, 
        filetypes = { "python" },
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      }

      vim.lsp.config.rust_analyzer = {
          cmd = { "rust-analyzer" },
            filetypes = { "rust" },
            root_markers = { "Cargo.toml", "rust-project.json", ".git" },
            settings = {
              ["rust_analyzer"] = {
                -- Optional: Add these settings for better Rust support
                cargo = {
                  allFeatures = true,
                  loadOutDirsFromCheck = true,
                },
                procMacro = {
                  enable = true,
                },
                checkOnSave = {
                  command = "clippy", -- Use clippy instead of check
                  extraArgs = { "--no-deps" },
                },
              },
            },
      }
            -- TypeScript/JavaScript
      vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { 
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
        },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      }

      -- CSS
      vim.lsp.config.cssls = {
        cmd = { "css-lsp", "--stdio" },
        filetypes = { "css", "scss", "sass", "less" },
        root_markers = { "package.json", ".git" },
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      }

      -- HTML
      vim.lsp.config.html = {
        cmd = { "html-lsp", "--stdio" },
        filetypes = { "html", "htmldjango" },
        root_markers = { "package.json", ".git" },
        settings = {
          html = {
            format = {
              enable = true,
            },
            suggest = {
              html5 = true,
            },
          },
        },
      }

      vim.lsp.config.gopls = {
        cmd = {"gopls"},
        filetypes = {"go"},
        -- Optional: Add these useful settings for better Go support
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            -- Add hints for better code navigation
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      }

      -- Enable the servers
      local servers = { 
          "clangd", "lua_ls", "asm_lsp", "pyright", "rust_analyzer", "ts_ls",
          "cssls", "html", "gopls"
      }
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
