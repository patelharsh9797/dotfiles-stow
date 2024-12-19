return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css-lsp",
        "hadolint",
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

        "typescript-language-server",
      })

      opts.ui = {
        height = 0.8,
        border = "rounded",
        -- icons = {
        --   package_installed = "✓",
        --   package_pending = "➜",
        --   package_uninstalled = "✗",
        -- },
      }
    end,
  },

  -- INFO:  typescript-tools config
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

  -- INFO: LSP Config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    opts = function(_, opts)
      -- LspInfo Border
      ---@diagnostic disable-next-line: no-unknown
      require("lspconfig.ui.windows").default_options.border = "rounded"

      local _border = "rounded"
      local _diagnostics_border = {
        { "", "DiagnosticHint" },
        { "─", "Comment" },
        { "╮", "Comment" },
        { "│", "Comment" },
        { "╯", "Comment" },
        { "─", "Comment" },
        { "╰", "Comment" },
        { "│", "Comment" },
      }

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = _border,
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = _border,
      })

      -- Customizing how diagnostics are displayed
      vim.diagnostic.config({
        ---@diagnostic disable-next-line: assign-type-mismatch
        float = { border = _diagnostics_border },
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
      })

      opts.inlay_hints = { enabled = false }

      opts.servers = {
        -- biome = {
        --   root_dir = util.root_pattern(""),
        -- },
        html = {},
        cssls = {},
        dockerls = {},
        docker_compose_language_service = {},
        marksman = {},
        prismals = {},
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
        -- json lsp
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
        -- python lsp & formatter & linter
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                pylsp_mypy = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },
              },
            },
          },
        },
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
          keys = {
            {
              "<leader>co",

              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      }

      -- some keymaps for all lang
      local keymap = vim.keymap -- for conciseness
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts_keymaps = { buffer = ev.buf, silent = true }

          -- -- set keybinds
          -- opts_keymaps.desc = "Show LSP references"
          -- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts_keymaps) -- show definition, references

          -- opts_keymaps.desc = "Go to declaration"
          -- keymap.set("n", "gD", vim.lsp.buf.declaration, opts_keymaps) -- go to declaration

          -- opts_keymaps.desc = "Show LSP definitions"
          -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts_keymaps) -- show lsp definitions

          -- opts_keymaps.desc = "Show LSP implementations"
          -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts_keymaps) -- show lsp implementations

          -- opts_keymaps.desc = "Show LSP type definitions"
          -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts_keymaps) -- show lsp type definitions

          -- opts_keymaps.desc = "See available code actions"
          -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts_keymaps) -- see available code actions, in visual mode will apply to selection

          -- opts_keymaps.desc = "Smart Rename"
          -- keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts_keymaps) -- smart rename

          -- opts_keymaps.desc = "Show buffer diagnostics"
          -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=1<CR>", opts_keymaps) -- show  diagnostics for file

          -- opts_keymaps.desc = "Show line diagnostics"
          -- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts_keymaps) -- show diagnostics for line

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

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      -- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      -- local signs = {
      --   Error = "󰅚 ",
      --   Warn = "󰳦 ",
      --   Hint = "󱡄 ",
      --   Info = " ",
      -- }
      -- for type, icon in pairs(signs) do
      --   local hl = "DiagnosticSign" .. type
      --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      -- end

      -- local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      -- for type, icon in pairs(signs) do
      --   local hl = "DiagnosticSign" .. type
      --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      -- end
    end,
  },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("venv-selector").setup()
    end,
  },
}
