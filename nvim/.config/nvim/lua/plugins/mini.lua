return {
  -- Extend and create a/i textobjects
  { "echasnovski/mini.ai", version = "*", config = true },

  -- Go forward/backward with square brackets
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost",
    config = function()
      local bracketed = require("mini.bracketed")
      bracketed.setup({
        file = { suffix = "" },
        window = { suffix = "" },
        quickfix = { suffix = "" },
        yank = { suffix = "" },
        treesitter = { suffix = "n" },
      })
    end,
  },

  -- Highlight patterns in text
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
          group = function(_, match)
            local utils = require("solarized-osaka.hsl")
            --- @type string, string, string
            local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
            --- @type number?, number?, number?
            local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
            --- @type string
            local hex_color = utils.hslToHex(h, s, l)
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
      },
    },
  },

  -- Icon provider
  {
    "echasnovski/mini.icons",
    config = function()
      local icons = require("mini.icons")
      -- icons.mock_nvim_web_devicons()
      local get_icon_tbl = function(category, name)
        local icon, hl = icons.get(category, name)
        return { glyph = icon, hl = hl }
      end
      local dockerfile_icon_tbl = get_icon_tbl("filetype", "dockerfile")
      local database_icon_tbl = get_icon_tbl("extension", "sql")

      icons.setup({
        file = {
          ["docker-compose.yml"] = dockerfile_icon_tbl,
          ["docker-compose.dev.yml"] = dockerfile_icon_tbl,
          ["docker-compose.prod.yml"] = dockerfile_icon_tbl,
          ["docker-compose.base.yml"] = dockerfile_icon_tbl,
        },
        extension = {
          db = database_icon_tbl,
        },
      })
    end,
  },

  -- Visualize and work with indent scope
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        animation = function()
          return 0
        end,
      },
    },
  },

  -- Move any selection in any direction
  {
    "echasnovski/mini.move",
    version = "*",
    event = "VeryLazy",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        -- Move current line in Normal mode
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    },
  },

  -- Text edit operators
  {
    "echasnovski/mini.operators",
    version = "*",
    opts = {
      -- Each entry configures one operator.
      -- `prefix` defines keys mapped during `setup()`: in Normal mode
      -- to operate on textobject and line, in Visual - on selection.

      -- Evaluate text and replace with output
      evaluate = {
        prefix = "g=",

        -- Function which does the evaluation

        func = nil,
      },

      -- Exchange text regions
      exchange = {
        prefix = "gx",

        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
      },

      -- Multiply (duplicate) text
      multiply = {
        prefix = "gm", -- gmm : duplicate line

        -- Function which can modify text before multiplying
        func = nil,
      },

      -- Sort text
      sort = {

        prefix = "gs",

        -- Function which does the sort
        func = nil,
      },
    },
  },

  -- Autopairs
  { "echasnovski/mini.pairs", version = "*", config = true },

  -- Extend and create a/i textobjects
  { "echasnovski/mini.surround", version = "*", config = true },
}
