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
                extensions = {
                    aerial = {
                        -- Set the width of the first two columns (the second
                        -- is relevant only when show_columns is set to 'both')
                        col1_width = 4,
                        col2_width = 30,
                        -- How to format the symbols
                        format_symbol = function(symbol_path, filetype)
                            if filetype == "json" or filetype == "yaml" then
                                return table.concat(symbol_path, ".")
                            else
                                return symbol_path[#symbol_path]
                            end
                        end,
                        -- Available modes: symbols, lines, both
                        show_columns = "both",
                    },
                },
            })

            -- Load fzf extension
            telescope.load_extension("fzf")
            telescope.load_extension("aerial")

            -- Keymaps
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>f", builtin.find_files, {})
            vim.keymap.set("n", "<leader>a", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>b", builtin.buffers, {})
            vim.keymap.set("n", "<leader>t", ":Telescope aerial<CR>", {})
            -- vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
            -- vim.keymap.set("n", "<leader>o", builtin.oldfiles, {})
        end,
    },
}
