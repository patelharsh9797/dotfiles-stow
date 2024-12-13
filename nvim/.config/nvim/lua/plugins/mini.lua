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

  -- -- files
  -- {
  --
  --   "echasnovski/mini.files",
  --   opts = {
  --     windows = {
  --       preview = true,
  --       width_focus = 30,
  --       width_preview = 30,
  --     },
  --     options = {
  --       -- Whether to use for editing directories
  --       -- Disabled by default in LazyVim because neo-tree is used for that
  --       use_as_default_explorer = false,
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>fm",
  --       function()
  --         require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
  --       end,
  --       desc = "Open mini.files (Directory of Current File)",
  --     },
  --     {
  --       "<leader>fM",
  --       function()
  --         require("mini.files").open(vim.uv.cwd(), true)
  --       end,
  --       desc = "Open mini.files (cwd)",
  --     },
  --   },
  -- },

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

      local test_icon = ""
      local js_table = { glyph = test_icon, hl = "MiniIconsYellow" }
      local jsx_table = { glyph = test_icon, hl = "MiniIconsYellow" }
      local ts_table = { glyph = test_icon, hl = "MiniIconsBlue" }
      local tsx_table = { glyph = test_icon, hl = "MiniIconsBlue" }

      icons.setup({
        -- Icon style: 'glyph' or 'ascii'
        style = "glyph",
        file = {
          ["docker-compose.yml"] = dockerfile_icon_tbl,
          ["docker-compose.dev.yml"] = dockerfile_icon_tbl,
          ["docker-compose.prod.yml"] = dockerfile_icon_tbl,
          ["docker-compose.base.yml"] = dockerfile_icon_tbl,
          [".dockerignore"] = dockerfile_icon_tbl,
          [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
          ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
          [".env"] = { glyph = "", hl = "MiniIconsYellow" },
          [".env.example"] = { glyph = "", hl = "MiniIconsYellow" },
        },
        extension = {
          db = { glyph = database_icon_tbl.glyph, hl = "MiniIconsYellow" },
          conf = { glyph = "", hl = "MiniIconsGrey" },
          sh = { glyph = "", hl = "MiniIconsGrey" },
          ["test.js"] = js_table,
          ["test.jsx"] = jsx_table,
          ["test.ts"] = ts_table,
          ["test.tsx"] = tsx_table,
          ["spec.js"] = js_table,
          ["spec.jsx"] = jsx_table,
          ["spec.ts"] = ts_table,
          ["spec.tsx"] = tsx_table,
          ["cy.js"] = js_table,
          ["cy.jsx"] = jsx_table,
          ["cy.ts"] = ts_table,
          ["cy.tsx"] = tsx_table,
        },
      })
    end,
  },

  -- Visualize and work with indent scope
  {
    "echasnovski/mini.indentscope",
    init = function()
      -- disable indent line on some filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "Trouble",
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "mason",
          "neo-tree",
          "notify",
          "snacks_dashboard",
          "snacks_notif",
          "snacks_terminal",
          "snacks_win",
          "toggleterm",
          "trouble",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      -- disable indent line on Snacks Dashboard window
      vim.api.nvim_create_autocmd("User", {
        pattern = "SnacksDashboardOpened",
        callback = function(data)
          vim.b[data.buf].miniindentscope_disable = true
        end,
      })
    end,
    opts = {
      symbol = "│", -- "╎"  --- "│"
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
