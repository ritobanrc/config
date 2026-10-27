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
map("n", "0", "g0", { silent = true })
map("n", "$", "g$", { silent = true })

-- Add these visual mode mappings
map("v", "j", "gj", { silent = true })
map("v", "k", "gk", { silent = true })
map("v", "0", "g0", { silent = true })
map("v", "$", "g$", { silent = true })

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

map("n", "<C-t>", "<cmd>AerialToggle!<CR>")

map("n", "<Leader>se", ":set spell spelllang=en<CR>")
map("n", "<Leader>ss", ":set spell spelllang=es keymap=accents<CR>")

map("i", "<C-s>", "<c-g>u<Esc>[s1z=`]a<c-g>u")

map("i", "<C-l>", "→<space>")
map("i", "<C-h>", "←<space>")
map("i", "<C-j>", "↓<space>")
map("i", "<C-k>", "↑<space>")


map("n", "<Leader>c<leader>", "gcc", {
        remap = true,
        desc = "Toggle comment"
      })

-- Visual mode: remap your leader key to the native 'gc'
map("x", "<Leader>c<leader>", "gc", {
  remap = true, 
  desc = "Toggle comment"
})
