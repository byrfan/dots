return {
{
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { 
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
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
  }
}
