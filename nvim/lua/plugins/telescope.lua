return {
{
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup({
      extensions = {
        fzf = {}
      }
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
    end
  }
}
