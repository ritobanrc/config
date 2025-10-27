-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 10
vim.opt.conceallevel = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"


-- Undo, backup, and swap file settings
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.backup = true
vim.opt.swapfile = true

-- Set directories for temporary files
local cache_dir = vim.fn.stdpath("cache")

vim.opt.undodir = cache_dir .. "/undo//"
vim.opt.backupdir = cache_dir .. "/backup//"
vim.opt.directory = cache_dir .. "/swap//"

-- Create directories if they don't exist
local function ensure_dir(path)
  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p", 0700)
  end
end

ensure_dir(vim.fn.stdpath("cache") .. "/undo")
ensure_dir(vim.fn.stdpath("cache") .. "/backup")
ensure_dir(vim.fn.stdpath("cache") .. "/swap")


