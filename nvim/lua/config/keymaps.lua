local map = vim.keymap.set
local utils = require('utils')

-- Disable arrow keys (The "Vim Tough Love" mode)
local modes = { "n", "v", "x", "s", "o", "c", "t" }
for _, mode in ipairs(modes) do
  map(mode, "<Up>", "<nop>")
  map(mode, "<Down>", "<nop>")
  map(mode, "<Left>", "<nop>")
  map(mode, "<Right>", "<nop>")
end




map("n", "<leader>n", utils.create_file_with_dir)

map("n", "<leader>p", function()
  vim.ui.input({ 
    prompt = "  Run Shell Command: ", 
    completion = "shell" 
  }, function(input)
    if not input or input == "" then return end
    
    -- Opens a split, runs the command, and keeps it open so you can see output
    vim.cmd("split | term " .. input)
    
    -- Optional: Auto-enter insert mode in the new terminal
    vim.cmd("startinsert")
  end)
end, { desc = "Terminal Command Palette" })
