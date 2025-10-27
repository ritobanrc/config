local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines
-- map("n", "<Tab>", ">>j")

-- Escape alternatives
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Terminal mode escape
map("t", "<Esc>", "<C-\\><C-n>")

-- Visual line navigation
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })

-- Better cursor positioning
map("n", "H", "^")
map("n", "L", "$")

-- Split window mappings
map("n", "_", function()
  local current_ft = vim.bo.filetype
  vim.cmd("new")
  vim.bo.filetype = current_ft
end, { desc = "Horizontal split with same filetype" })

map("n", "|", function()
  local current_ft = vim.bo.filetype
  vim.cmd("vnew")
  vim.bo.filetype = current_ft
end, { desc = "Vertical split with same filetype" })

-- Open new tab in current directory
map("n", "<leader>-", function()
  vim.cmd("tabedit " .. vim.fn.expand("%:p:h"))
end, { desc = "New tab in current directory" })

-- Close buffer and/or tab
map("n", "<leader>q", ":bd<CR>:silent tabclose<CR>gT", { desc = "Close buffer and tab" })

-- Tab navigation
map("n", "<Tab>", ":tabnext<CR>", { silent = true, desc = "Next tab" })
map("n", "<S-Tab>", ":tabfirst<CR>", { silent = true, desc = "First tab" })
