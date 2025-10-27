-- ~/.config/nvim/lua/config/autocmds.lua

-- Auto-save for specific filetypes
vim.api.nvim_create_augroup("autosave", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "autosave",
  pattern = { "markdown", "python" },
  callback = function()
    vim.b.auto_save = 1
  end,
})

-- Rust formatting
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.g.rustfmt_autosave = 1
  end,
})

-- Disable auto-indent for tex files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.autoindent = false
  end,
})

-- Reload file if changed outside vim
vim.api.nvim_create_augroup("load_changed_file", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = "load_changed_file",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = "load_changed_file",
  callback = function()
    print("Changes loaded from source file")
  end,
})

-- Restore cursor position
vim.api.nvim_create_augroup("save_cursor_position", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "save_cursor_position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Spell and wrap settings for markdown/tex
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "tex", "latex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.list = false
  end,
})
