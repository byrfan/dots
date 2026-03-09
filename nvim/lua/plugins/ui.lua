return {
  -- Nightfox (provides carbonfox)
  {
    "EdenEast/nightfox.nvim",
    lazy = false,    -- Load this immediately on startup
    priority = 1000, -- Make sure this loads before other plugins
    config = function()
      -- Load the carbonfox variant
      vim.cmd("colorscheme carbonfox")
    end,
  },

  -- Kanagawa (keeping it as a backup/alternative)
  { "rebelot/kanagawa.nvim" },

  -- Lualine (now it will automatically match carbonfox)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = 'auto', -- 'auto' will now pick up carbonfox colors
      },
    },
  },
  {
    "stevearc/dressing.nvim",
        opts = {
          input = {
            enabled = true,
            default_prompt = "➤ ", -- A clean fallback icon
            title_pos = "center",
            insert_only = false,
            start_in_insert = true,
            -- This is where we define the look
            relative = "editor",
            prefer_width = 40,
            win_options = {
              winblend = 10, -- Slight transparency for that modern look
          },
      },
    },
  },
  {
    "stevearc/oil.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      cmd = {"Oil"},
      opts = {
        -- Use a floating window instead of a buffer
        skip_confirm_for_simple_edits = true,
        --
        --
        --confirmation = {
            --disable_confirm_for_groups = { "all" },
        --},
        --
        float = {
          padding = 2,
          max_width = 90,
          max_height = 0,
          border = "rounded", -- Options: "single", "double", "shadow", "curved"
          win_options = {
            winblend = 0,
          },
          -- This is the default focus behavior
          -- preview_split: 'auto', 'right', 'left', 'above', 'below'
          preview_split = "auto",
        },
        -- Configuration for the appearance and behavior
        view_options = {
          show_hidden = true,
        },
      },
      keys = {
        -- Setting this to open specifically as a float
      { "<Leader>o", "<CMD>Oil --float<CR>", desc = "Open oil in a floating window" },
      }
  },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      local logo = require("logos")

      dashboard.section.header.val = logo
      dashboard.section.header.opts.hl = "Function"

      -- 2. The Menu (Buttons)
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
        dashboard.button("o", "  Open Oil", "<CMD>Oil --float <CR>"),
        dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- 3. The Centering & Layout
      -- Alpha uses "padding" elements to create space
      dashboard.config.layout = {
        { type = "padding", val = 4 }, -- Space at the very top
        dashboard.section.header,
        { type = "padding", val = 2 }, -- Space between tree and menu
        dashboard.section.buttons,
        dashboard.section.footer,
      }

      alpha.setup(dashboard.opts)
    end
  },
}

