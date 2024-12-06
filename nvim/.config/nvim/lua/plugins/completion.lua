return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp", -- source for neovim built-in LSP
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-buffer", -- source for text in buffer
      {
        "L3MON4D3/LuaSnip",
        lazy = true,
        build = (not LazyVim.is_win())
            and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
          or nil,
        opts = function(_, opts)
          ---@diagnostic disable-next-line: duplicate-set-field
          LazyVim.cmp.actions.snippet_forward = function()
            if require("luasnip").jumpable(1) then
              require("luasnip").jump(1)
              return true
            end
          end
          opts.history = true
          opts.delete_check_events = "TextChanged"
        end,
      }, -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
    },
    opts = function(_, opts)
      opts.window = {
        completion = {
          border = {
            { "󱐋", "WarningMsg" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          scrollbar = false,
          winblend = 0,
        },
        documentation = {
          border = {
            { "󰙎", "DiagnosticHint" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },

          scrollbar = false,
          winblend = 0,
        },
      }

      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      table.insert(opts.sources, { name = "luasnip" })

      table.insert(opts.sources, { name = "emoji" })

      -- python specific
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
    end,
    config = function()
      vim.api.nvim_set_keymap(
        "i",
        "<Tab>",
        "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
        { silent = true, expr = true }
      )
      vim.api.nvim_set_keymap("i", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { silent = true })
      vim.api.nvim_set_keymap("s", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>", { silent = true })
      vim.api.nvim_set_keymap("s", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { silent = true })

      -- local luasnip = require("luasnip")
      -- vim.keymap.set({ "i", "s" }, "<Tab>", function()
      --   luasnip.jump(1)
      -- end, { silent = true })
      -- vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      --   luasnip.jump(-1)
      -- end, { silent = true })

      -- luasnip.setup({
      --   region_check_events = "CursorHold,InsertLeave",
      --   delete_check_events = "TextChanged,InsertEnter",
      -- })

      local cmp = require("cmp")
      local lspkind = require("lspkind")
      lspkind.init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
          Copilot = "",
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      })

      -- local kind_formatter = lspkind.cmp_format({
      --   mode = "symbol_text",
      --   menu = {
      --     buffer = "[buf]",
      --     nvim_lsp = "[LSP]",
      --     nvim_lua = "[api]",
      --     path = "[path]",
      --     luasnip = "[snip]",
      --     gh_issues = "[issues]",
      --     tn = "[TabNine]",
      --     eruby = "[erb]",
      --   },
      -- })

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = {
              -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
              -- can also be a function to dynamically calculate max width such as
              -- menu = function() return math.floor(0.45 * vim.o.columns) end,
              menu = 50, -- leading text (labelDetails)
              abbr = 50, -- actual suggestion item
            },
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = { -- add border for autocompletion menu
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete({}), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion
          ---@diagnostic disable-next-line: no-unknown
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "path" },
          { name = "buffer" },
        }),
      })
    end,
  },
}
