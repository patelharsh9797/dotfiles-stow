return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   opts = {
  --     variant = "moon", -- auto, main, moon, or dawn
  --     dark_variant = "dawn", -- main, moon, or dawn
  --     styles = {
  --       bold = true,
  --       italic = true,
  --       transparency = true,
  --     },
  --   },
  -- },

  -- {
  --   -- enabled = false,
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   opts = function(_, opts)
  --     opts.transparent = true
  --     opts.italic_comments = true
  --     opts.terminal_colors = true
  --     opts.hide_fillchars = false
  --     opts.borderless_telescope = false
  --   end,
  -- },
  -- -- modicator (auto color line number based on vim mode)
  -- {
  --   enabled = false,
  --   "mawkler/modicator.nvim",
  --   dependencies = "scottmckendry/cyberdream.nvim",
  --   init = function()
  --     -- These are required for Modicator to work
  --     vim.o.cursorline = false
  --     vim.o.number = true
  --     vim.o.termguicolors = true
  --   end,
  --   opts = {},
  -- },

  {
    enabled = true,
    "catppuccin/nvim",
    version = "*",
    -- version = "v1.11.0",
    -- lazy = true,
    priority = 1000, -- make sure to load this before all the other catppuccin colorschemes
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true,
      -- transparent = true,
      float = {
        transparent = true,
        solid = false,
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      auto_integrations = true,
      integrations = {
        alpha = true,
        blink_cmp = {
          style = "bordered",
        },
        bufferline = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        markview = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = {
          enabled = true,
        },
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    enabled = false,
    "folke/tokyonight.nvim",
    opts = {
      style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    enabled = true,
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local p = require("poimandres.palette")
      require("poimandres").setup({
        bold_vert_split = true, -- use bold vertical separators
        dim_nc_background = true, -- dim 'non-current' window backgrounds
        disable_background = true, -- disable background
        disable_float_background = true, -- disable background for floats
        disable_italics = false, -- disable italics
        highlight_groups = {
          WhichKeyFloat = { bg = p.none },
          -- LspReferenceText = { bg = p.background3 },
          -- LspReferenceRead = { bg = p.background3 },
          -- LspReferenceWrite = { bg = p.background3 },
          LspReferenceText = { link = "visual" },
          LspReferenceRead = { link = "visual" },
          LspReferenceWrite = { link = "visual" },
        },
      })
      require("notify").setup({
        background_colour = "#0f0f0f",
      })
    end,
  },
}
