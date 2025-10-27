return {
  -- Colorscheme
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_transparent_background = 1
      vim.g.everforest_better_performance = 1
      vim.cmd([[colorscheme everforest]])
    end,
  },
  
  -- Statusline (optional upgrade from lightline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "everforest",
        },
      })
    end,
  },

  -- File explorer (optional upgrade from NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {})
    end,
  },

  -- Goyo - Distraction-free writing
  {
    "junegunn/goyo.vim",
    cmd = "Goyo", -- Lazy load on command
    keys = {
      { "<leader>g", ":Goyo<CR>", desc = "Toggle Goyo (distraction-free mode)" },
    },
    config = function()
      -- Optional: Configure Goyo dimensions
--      vim.g.goyo_width = 120
--      vim.g.goyo_height = "85%"
--
--      -- Optional: Setup callbacks for entering/leaving Goyo
--      vim.api.nvim_create_autocmd("User", {
--        pattern = "GoyoEnter",
--        callback = function()
--          vim.opt.showmode = false
--          vim.opt.showcmd = false
--          vim.opt.scrolloff = 999 -- Keep cursor centered
--        end,
--      })
--
--      vim.api.nvim_create_autocmd("User", {
--        pattern = "GoyoLeave",
--        callback = function()
--          vim.opt.showmode = true
--          vim.opt.showcmd = true
--          vim.opt.scrolloff = 8
--        end,
--      })
    end,
  },
}

