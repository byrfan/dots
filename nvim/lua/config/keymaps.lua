local map = vim.keymap.set

-- Disable arrow keys (The "Vim Tough Love" mode)
local modes = { "n", "v", "x", "s", "o", "c", "t" }
for _, mode in ipairs(modes) do
  map(mode, "<Up>", "<nop>")
  map(mode, "<Down>", "<nop>")
  map(mode, "<Left>", "<nop>")
  map(mode, "<Right>", "<nop>")
end

-- Add your new Leader-based maps here later
-- map("n", "<leader>w", ":w<CR>")
