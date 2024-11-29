return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css-lsp",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "prettier",
        "prisma-language-server",
        "selene",
        "shellcheck",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "yaml-language-server",
      })

      opts.ui = {
        height = 0.8,
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      }
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    event = "BufEnter",
    opts = function(_, opts)
      -- custom keymasps
      vim.api.nvim_set_keymap("n", "<leader>ci", "<cmd>TSToolsAddMissingImports<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>co", "<cmd>TSToolsOrganizeImports<CR>", { noremap = true, silent = true })

      require("typescript-tools").setup({
        -- on_attach = function(client, bufnr)
        --   -- Add any custom on_attach configuration here
        --   -- For example, set key mappings for LSP functionality
        --   local opts = { noremap = true, silent = true, buffer = bufnr }
        --   local buf_set_keymap = vim.api.nvim_buf_set_keymap
        --
        --   buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        --   buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        --   buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        --   buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
        -- end,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          tsserver_file_preferences = {
            importModuleSpecifierPreference = "non-relative",
            providePrefixAndSuffixTextForRename = false,
          },
          tsserver_plugins = { "typescript-plugin-css-modules" },
          separate_diagnostic_server = true,
          tsserver_format_options = {}, -- Customize tsserver formatting options
          publish_diagnostic_on = "insert_leave",
          expose_as_code_action = {
            "fix_all", -- Show "Fix All" in code actions
            "add_missing_imports", -- Show "Add Missing Imports" in code actions
            "remove_unused", -- Show "Remove Unused" in code actions
          },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
    },
    opts = function(_, opts)
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- LspInfo Border
      require("lspconfig.ui.windows").default_options.border = "rounded"

      opts.inlay_hints = { enabled = false }

      opts.servers = {
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
        vtsls = {
          enabled = false,
        },
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        html = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      }

      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local keymap = vim.keymap -- for conciseness

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts_keymaps = { buffer = ev.buf, silent = true }

          -- set keybinds
          opts_keymaps.desc = "Show LSP references"
          keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts_keymaps) -- show definition, references

          opts_keymaps.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts_keymaps) -- go to declaration

          opts_keymaps.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts_keymaps) -- show lsp definitions

          opts_keymaps.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts_keymaps) -- show lsp implementations

          opts_keymaps.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts_keymaps) -- show lsp type definitions

          opts_keymaps.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts_keymaps) -- see available code actions, in visual mode will apply to selection

          opts_keymaps.desc = "Smart Rename"
          keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts_keymaps) -- smart rename

          opts_keymaps.desc = "Show buffer diagnostics"
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=1<CR>", opts_keymaps) -- show  diagnostics for file

          opts_keymaps.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts_keymaps) -- show diagnostics for line

          opts_keymaps.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts_keymaps) -- jump to previous diagnostic in buffer

          opts_keymaps.desc = "Go to next diagnostic"
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts_keymaps) -- jump to next diagnostic in buffer

          opts_keymaps.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts_keymaps) -- show documentation for what is under cursor

          opts_keymaps.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts_keymaps) -- mapping to restart lsp if necessary
        end,
      })

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      mason_lspconfig.setup_handlers({
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["emmet_ls"] = function()
          -- configure emmet language server
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,
        ["lua_ls"] = function()
          -- configure lua server (with special settings)
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      })
    end,
  },
}
