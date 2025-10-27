return {
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge between Mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        -- Auto-install these servers
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "clangd",
          "pylsp",
          "tinymist", -- for Typst
          "jdtls", -- for Typst
        },
        -- Automatic setup for all installed servers
        handlers = {
          -- Default handler - applies to all servers
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          
          -- Custom handler for specific servers
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,
          
          ["tinymist"] = function()
            require("lspconfig").tinymist.setup({
              settings = {
                formatterMode = "typstyle",
                exportPdf = "onType",
                semanticTokens = "disable",
              },
            })
          end,
        },
      })
    end,
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
}
