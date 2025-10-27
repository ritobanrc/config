-- return {
--   {
--     "numToStr/Comment.nvim",
--     event = "VeryLazy",
--     config = function()
--       require("Comment").setup({
--         -- Add a space b/w comment and the line
--         padding = true,
--         -- Whether the cursor should stay at its position
--         sticky = true,
--         -- Lines to be ignored while (un)comment
--         ignore = nil,
--         -- LHS of toggle mappings in NORMAL mode
--         toggler = {
--           line = "<Leader>cc",  -- Line-comment toggle keymap
--           block = "<Leader>dc", -- Block-comment toggle keymap
--         },
--         -- LHS of operator-pending mappings in NORMAL and VISUAL mode
--         opleader = {
--           line = "<Leader>c",   -- Line-comment keymap
--           block = "<Leader>b",  -- Block-comment keymap
--         },
--         -- LHS of extra mappings
--         extra = {
--           above = "gcO", -- Add comment on the line above
--           below = "gco", -- Add comment on the line below
--           eol = "gcA",   -- Add comment at the end of line
--         },
--         -- Enable keybindings
--         -- NOTE: If given `false` then the plugin won't create any mappings
--         mappings = {
--           basic = true,
--           extra = true,
--         },
--       })
--     end,
--   },
-- }
--
-- ~/.config/nvim/lua/plugins/commenting.lua

return {
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,

        -- Disable all default mappings
        toggler = {
          line = nil,
          block = nil,
        },
        opleader = {
          line = nil,
          block = nil,
        },
        extra = {
          above = nil,
          below = nil,
          eol = nil,
        },
        mappings = {
          basic = false,   -- Disable gcc, gbc, gc, gb mappings
          extra = false,   -- Disable gco, gcO, gcA mappings
        },
      })

      -- Custom mappings: <Leader>cc for everything
      local api = require("Comment.api")

      -- Normal mode: toggle comment on current line
      vim.keymap.set("n", "<Leader>cc", api.toggle.linewise.current, 
        { desc = "Toggle comment" })

      -- Visual mode: toggle comment on selection (works for both line and block)
      vim.keymap.set("x", "<Leader>cc", function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = "Toggle comment" })
    end,
  },
}
