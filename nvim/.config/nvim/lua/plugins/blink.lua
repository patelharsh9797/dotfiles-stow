return {
  "saghen/blink.cmp",
  version = not vim.g.lazyvim_blink_main and "*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
  },
  dependencies = {
    "codeium.vim", -- codeium.nvim
    { -- vscode snippets
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    "L3MON4D3/LuaSnip",
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
    local ls = require("luasnip")

    require("blink.cmp").setup({
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",

        -- kind_icons = vim.tbl_extend("keep", {
        --   Color = "██", -- Use block instead of icon for color items to make swatches more usable
        -- }, LazyVim.config.icons.kinds),
      },
      snippets = {
        expand = function(snippet)
          ls.lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return ls.jumpable(filter.direction)
          end
          return ls.in_snippet()
        end,
        jump = function(direction)
          ls.jump(direction)
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
          luasnip = {
            name = "luasnip",
            module = "blink_luasnip",

            score_offset = -1,

            opts = {
              use_show_condition = false,
              show_autosnippets = true,
            },
          },
        },
      },

      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
          "fallback",
        },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" }, -- previous suggestion
        ["<C-j>"] = { "select_next", "fallback" }, -- next suggestion
      },
    })
  end,
}
