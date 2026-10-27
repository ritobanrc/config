return {
    -- Mason for managing LSP servers
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "clangd",
                    "pylsp",
                    "tinymist",
                    "texlab",
                },
            })

            -- Lua with custom settings
            vim.lsp.config['lua_ls'] = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            }

            -- Tinymist with nested settings structure
            vim.lsp.config['tinymist'] = {
                cmd = { "tinymist" },
                filetypes = { "typst" },
                settings = {
                    formatterMode = "typstyle",
                    exportPdf = "onType",
                    semanticTokens = "disable",
                },
            }
        end,
    },

    {
        'chomosuke/typst-preview.nvim',
        lazy = false, -- or ft = 'typst'
        version = '1.*',
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`

    },

    -- LSP keybindings
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Set up keymaps when LSP attaches
            vim.diagnostic.config({
                virtual_text = false, -- Disable inline virtual text
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    source = "always",
                    border = "rounded",
                    header = "",
                    prefix = "",
                },
            })

            vim.api.nvim_create_user_command("OpenPdf", function()
                local filepath = vim.api.nvim_buf_get_name(0)
                if filepath:match("%.typ$") then
                    -- Replace 'open' with your preferred pdf viewer
                    -- macOS: open -a Zathura (or open -a Preview, open -a Skim, etc.)
                    -- Linux: zathura, evince, okular, etc.
                    os.execute("zathura --fork " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")))
                else
                    print("Not a Typst file")
                end
            end, { desc = "Open PDF for current Typst file" })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }

                    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float,
                    { buffer = args.buf, desc = "Show diagnostics" })
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                end,
            })
        end,
    },

    {
        "let-def/texpresso.vim",
    }
}
