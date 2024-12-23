return {
  "saghen/blink.cmp",
  version = not vim.g.lazyvim_blink_main and "*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)
  end,
  dependencies = {
    "codeium.vim", -- codeium.nvim
    { -- vscode snippets
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
      end,
    },
    {
      "L3MON4D3/LuaSnip",
      opts = function()
        LazyVim.cmp.actions.snippet_forward = function()
          if require("luasnip").jumpable(1) then
            require("luasnip").jump(1)
            return true
          end
        end
        LazyVim.cmp.actions.snippet_stop = function()
          if require("luasnip").expand_or_jumpable() then -- or just jumpable(1) is fine?
            require("luasnip").unlink_current()
            return true
          end
        end
      end,
    },
    "leiserfg/blink_luasnip",
    {
      "saghen/blink.compat",
      optional = true, -- make optional so it's only enabled if any extras need it
      opts = { impersonate_nvim_cmp = true },
      version = not vim.g.lazyvim_blink_main and "*",
    },
  },

  event = "InsertEnter",

  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  config = function(_, opts)
    require("blink.cmp").setup({
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",

        kind_icons = vim.tbl_extend("keep", {
          Color = "██", -- Use block instead of icon for color items to make swatches more usable
        }, LazyVim.config.icons.kinds),

        -- kind_icons = {
        --   Copilot = "",
        --   Text = "󰉿",
        --   Method = "󰊕",
        --   Function = "󰊕",
        --   Constructor = "󰒓",
        --
        --   Field = "󰜢",
        --   Variable = "󰆦",
        --   Property = "󰖷",
        --
        --   Class = "󱡠",
        --   Interface = "󱡠",
        --   Struct = "󱡠",
        --   Module = "󰅩",
        --
        --   Unit = "󰪚",
        --   Value = "󰦨",
        --   Enum = "󰦨",
        --   EnumMember = "󰦨",
        --
        --   Keyword = "󰻾",
        --   Constant = "󰏿",
        --
        --   Snippet = "󱄽",
        --   Color = "󰏘",
        --   File = "󰈔",
        --   Reference = "󰬲",
        --   Folder = "󰉋",
        --   Event = "󱐋",
        --   Operator = "󰪚",
        --   TypeParameter = "󰬛",
        -- },
      },

      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },

      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
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
          winblend = 0,
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None", -- blink docs
          scrolloff = 2,
          scrollbar = true,
          -- winhighlight = "Normal:None,FloatBorder:BlinkCmpDocBorder,CursorLine:CursorLine,Search:None",
          draw = {
            columns = {
              { "label", "label_description", gap = 2 },
              { "kind_icon", "kind", gap = 2 },
            },
            treesitter = { "lsp" },
          },
        },
        documentation = {
          window = {
            border = {
              { "", "DiagnosticHint" },
              { "─", "Comment" },
              { "╮", "Comment" },
              { "│", "Comment" },
              { "╯", "Comment" },
              { "─", "Comment" },
              { "╰", "Comment" },
              { "│", "Comment" },
            },
            winblend = 0,
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
            scrollbar = true,
          },
          auto_show = true,
          auto_show_delay_ms = 200,
          treesitter_highlighting = true,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      signature = {
        enabled = false,
        window = {
          border = {
            { "", "DiagnosticHint" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          winhighlight = "Normal:None,FloatBorder:BlinkCmpDocBorder",
        },
      },

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        -- compat = { "codeium" },
        default = { "lsp", "path", "luasnip", "buffer" },
        cmdline = {},
        providers = {
          -- codeium = { kind = "Codeium" },
          -- lsp = {
          --   name = "lsp",
          --   enabled = true,
          --   module = "blink.cmp.sources.lsp",
          --   -- kind = "LSP",
          --   score_offset = 1000, -- the higher the score, the higher the priority
          -- },
          -- luasnip = {
          --   name = "luasnip",
          --   enabled = true,
          --   module = "blink.cmp.sources.luasnip",
          --   score_offset = 950, -- the higher the number, the higher the priority
          -- },
        },
      },
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
              -- else
              --   return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        -- ["<Tab>"] = {
        --   LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
        --   "fallback",
        -- },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" }, -- previous suggestion
        ["<C-j>"] = { "select_next", "fallback" }, -- next suggestion
      },
    })
  end,
}
