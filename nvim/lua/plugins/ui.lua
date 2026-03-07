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
}
