return {
  -- Create annotations with one keybind, and jump your cursor in the inserted annotation
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },

  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = function()
      require("inc_rename").setup()
      -- Keybinding for Incremental Rename
      vim.keymap.set("n", "<leader>ri", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "Incremental Rename" })
    end,
    keys = {
      { "<leader>ri", desc = "Incremental Rename" },
    },
  },
  -- {
  --   "smjonas/inc-rename.nvim",
  --   cmd = "IncRename",
  --   config = function()
  --     require("inc_rename").setup({
  --       input_buffer_type = "dressing",
  --       show_message = true,
  --       preview_empty_name = true,
  --     })
  --
  --     -- Keymapping with error handling
  --     vim.keymap.set("n", "<leader>rn", function()
  --       local curr_name = vim.fn.expand("<cword>")
  --       if curr_name and curr_name ~= "" then
  --         vim.cmd("IncRename " .. curr_name)
  --       else
  --         vim.notify("No word under cursor to rename", vim.log.levels.WARN)
  --       end
  --     end, { desc = "Incremental Rename" })
  --   end,
  --   dependencies = {
  --     "stevearc/dressing.nvim", -- Optional but recommended
  --   },
  -- },

  -- Refactoring tool
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    opts = {},
  },

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

  -- Better increase/descrease
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
        },
      })
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    cmd = "SymbolsOutline",
    opts = {
      position = "right",
    },
  },

  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
