return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })

      -- Load fzf extension
      telescope.load_extension("fzf")

      -- Keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", builtin.find_files, {})
      vim.keymap.set("n", "<leader>a", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>b", builtin.buffers, {})
      -- vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
      -- vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})
    end,
  },
}
