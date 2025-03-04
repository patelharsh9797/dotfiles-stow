local trigger_text = ";"
-- local local_kind_icons = vim.tbl_extend("force", {
--   Color = "██", -- Use block instead of icon for color items to make swatches more usable
-- }, LazyVim.config.icons.kinds)

return {
  "saghen/blink.cmp",
  version = not vim.g.lazyvim_blink_main and "*",
  -- In case there are breaking changes and you want to go back to the last
  -- working release
  -- https://github.com/Saghen/blink.cmp/releases
  -- version = "v0.9.3",

  dependencies = {
    -- { "codeium.vim", dependencies = { "saghen/blink.compat" } }, -- codeium.nvim
    { -- vscode snippets
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip").filetype_extend("typescript", { "typescriptreact" })
        require("luasnip").filetype_extend("javascript", { "javascriptreact" })
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    {
      "L3MON4D3/LuaSnip",
      -- opts = function()
      --   LazyVim.cmp.actions.snippet_forward = function()
      --     if require("luasnip").jumpable(1) then
      --       require("luasnip").jump(1)
      --       return true
      --     end
      --   end
      --   LazyVim.cmp.actions.snippet_stop = function()
      --     if require("luasnip").expand_or_jumpable() then -- or just jumpable(1) is fine?
      --       require("luasnip").unlink_current()
      --       return true
      --     end
      --   end
      -- end,
    },

    -- "leiserfg/blink_luasnip",
    "moyiz/blink-emoji.nvim",
    "Kaiser-Yang/blink-cmp-dictionary",
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
  opts = function(_, opts)
    -- opts.enabled = function()
    --   -- Get the current buffer's filetype
    --   local filetype = vim.bo[0].filetype
    --   -- Disable for Telescope buffers
    --   if filetype == "TelescopePrompt" or filetype == "minifiles" or filetype == "snacks_picker_input" then
    --     return false
    --   end
    --   return true
    -- end,

    opts.appearance = vim.tbl_deep_extend("force", opts.appearance or {}, {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = true,
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
      -- kind_icons = local_kind_icons,

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
    })

    opts.snippets = vim.tbl_deep_extend("force", opts.snippets, {
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
    })

    opts.completion = vim.tbl_deep_extend("force", opts.completion, {
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
          components = {
            kind_icon = {
              ellipsis = true,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
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
    })

    opts.signature = vim.tbl_deep_extend("force", opts.signature or {}, {

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
    })

    opts.cmdline = {
      enabled = false,
    }

    opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
      default = { "lsp", "snippets", "path", "buffer", "dictionary", "emoji" },
      providers = {
        -- codeium = {
        --   name = "codeium",
        --   module = "blink.compat.source",
        --   -- kind = "Codeium",
        --   score_offset = 100,
        --   async = true,
        -- },

        -- supermaven = {
        --   name = "supermaven",
        --   module = "blink.compat.source",
        --   -- kind = "Supermaven",
        --   score_offset = 10,
        --   async = true,
        -- },

        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          -- kind = "LSP",
          -- min_keyword_length = 2,
          -- score_offset = 1000, -- the higher the score, the higher the priority
        },
        snippets = {
          name = "snippets",
          enabled = true,
          module = "blink.cmp.sources.snippets",
          max_items = 10,
          min_keyword_length = 1,
          score_offset = 10, -- the higher the number, the higher the priority
          -- Only show snippets if I type the trigger_text characters, so
          -- to expand the "bash" snippet, if the trigger_text is ";" I have to
          should_show_items = function()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
            -- NOTE: remember that `trigger_text` is modified at the top of the file
            return before_cursor:match(trigger_text .. "%w*$") ~= nil
          end,
          -- After accepting the completion, delete the trigger_text characters
          -- from the final inserted text
          transform_items = function(_, items)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
            local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
            if trigger_pos then
              for _, item in ipairs(items) do
                item.textEdit = {
                  newText = item.insertText or item.label,
                  range = {
                    start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
                    ["end"] = { line = vim.fn.line(".") - 1, character = col },
                  },
                }
              end
            end
            --   -- NOTE: After the transformation, I have to reload the luasnip source
            --   -- Otherwise really crazy shit happens and I spent way too much time
            --   -- figuring this out
            vim.schedule(function()
              require("blink.cmp").reload("snippets")
            end)
            return items
          end,
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
          max_items = 5,
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 4,
          -- score_offset = 15, -- the higher the number, the higher the priority
        },
        dictionary = {
          module = "blink-cmp-dictionary",
          name = "Dict",
          -- score_offset = 20,
          enabled = true,
          max_items = 8,
          min_keyword_length = 2,
          opts = {
            -- dictionary_directories = { vim.fn.expand("~/github/dotfiles-latest/dictionaries") },
            dictionary_files = {
              vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
            },
          },
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
    })

    opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
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
    })

    return opts
  end,
}
