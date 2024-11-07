return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css-lsp",
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
        -- "typescript-language-server",
        "vtsls",
        -- "yaml-language-server",
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
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- LspInfo Border
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
        vtsls = {
          enabled = false,
        },
      },
    },
  },
}
