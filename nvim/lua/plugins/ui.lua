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
}
