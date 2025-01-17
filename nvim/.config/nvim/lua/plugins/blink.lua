local trigger_text = ";"

return {
  "saghen/blink.cmp",
  version = not vim.g.lazyvim_blink_main and "*",
  -- In case there are breaking changes and you want to go back to the last
  -- working release
  -- https://github.com/Saghen/blink.cmp/releases
  -- version = "v0.9.3",
  -- config = function(_, opts)
  --   require("blink.cmp").setup(opts)
  -- end,
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
    -- "leiserfg/blink_luasnip",
    "moyiz/blink-emoji.nvim",
    {
      "saghen/blink.compat",
      optional = true, -- make optional so it's only enabled if any extras need it
      opts = { impersonate_nvim_cmp = true },
      version = not vim.g.lazyvim_blink_main and "*",
    },
  },
  opts_extend = {
    "sources.completion.enabled_providers",
    "sources.compat",
    "sources.default",
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
        preset = "luasnip",
        -- expand = function(snippet, _)
        --   return LazyVim.cmp.expand(snippet)
        -- end,

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
        default = { "lsp", "path", "snippets", "buffer", "emoji" },
        cmdline = {},
        providers = {
          -- codeium = { kind = "Codeium" },
          lsp = {
            name = "lsp",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            -- kind = "LSP",
            -- score_offset = 1000, -- the higher the score, the higher the priority
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            -- score_offset = 25,
            -- When typing a path, I would get snippets and text in the
            -- suggestions, I want those to show only if there are no path
            -- suggestions
            fallbacks = { "snippets", "buffer" },
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          buffer = {
            name = "Buffer",
            enabled = true,
            max_items = 3,
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 4,
            -- score_offset = 15, -- the higher the number, the higher the priority
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            -- score_offset = 15, -- Tune by preference
            opts = { insert = true }, -- Insert emoji (default) or complete its name
          },
          -- luasnip = {
          --   name = "luasnip",
          --   module = "blink_luasnip",
          --
          --   score_offset = -3,
          --
          --   ---@module 'blink_luasnip'
          --   ---@type blink_luasnip.Options
          --   opts = {
          --     use_show_condition = false, -- disables filtering completion candidates
          --     show_autosnippets = true,
          --     show_ghost_text = false, -- whether to show a preview of the selected snippet (experimental)
          --   },
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
