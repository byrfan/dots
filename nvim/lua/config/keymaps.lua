local map = vim.keymap.set

-- Disable arrow keys (The "Vim Tough Love" mode)
local modes = { "n", "v", "x", "s", "o", "c", "t" }
for _, mode in ipairs(modes) do
  map(mode, "<Up>", "<nop>")
  map(mode, "<Down>", "<nop>")
  map(mode, "<Left>", "<nop>")
  map(mode, "<Right>", "<nop>")
end

map("n", "<leader>n", function()
  local icon = "  "
  vim.ui.input({ prompt = icon .. "New File", completion = "file" }, function(input)
    if not input or input == "" then return end
    
    -- Just open the buffer (folder doesn't exist yet)
    vim.cmd("edit " .. input)

    -- Create an autocommand for THIS buffer only
    -- It triggers right before you save (BufWritePre)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0, -- 0 means 'the current buffer'
      once = true, -- Only run this once, then delete the autocommand
      callback = function()
        local dir = vim.fn.fnamemodify(input, ":h")
        if vim.fn.isdirectory(dir) == 0 then
          vim.fn.mkdir(dir, "p")
        end
      end,
    })
  end)
end, { desc = "Create file (Lazy Folder Creation)" })

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
