return {
  -- Comment
  --
  -- NORMAL mode
  -- `gcc` - Toggles the current line using linewise comment
  -- `gbc` - Toggles the current line using blockwise comment
  -- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
  -- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
  -- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
  -- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
  --
  -- VISUAL mode
  -- `gc` - Toggles the region using linewise comment
  --
  -- `gb` - Toggles the region using blockwise comment
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- import comment plugin safely
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      -- enable comment
      comment.setup({
        -- for commenting tsx and jsx files
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },

  -- Incremental rename
  -- {
  --   "smjonas/inc-rename.nvim",
  --   cmd = "IncRename",
  --   config = function()
  --     require("inc_rename").setup()
  --     -- Keybinding for Incremental Rename
  --     vim.keymap.set("n", "<leader>ri", function()
  --       return ":IncRename " .. vim.fn.expand("<cword>")
  --     end, { expr = true, desc = "Incremental Rename" })
  --   end,
  --   keys = {
  --     { "<leader>ri", desc = "Incremental Rename" },
  --   },
  -- },

  -- Refactoring tool
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      -- {
      --   "<leader>rr",
      --   function()
      --     require("refactoring").select_refactor()
      --   end,
      --   mode = "v",
      --   noremap = true,
      --   silent = true,
      --   expr = false,
      --   desc = "Select refactoring",
      -- },
      {
        "<leader>rs",
        pick,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
        desc = "Select Refactoring",
      },
      {
        "<leader>rf",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "v",
        desc = "Extract Function",
      },
      {
        "<leader>rF",
        function()
          require("refactoring").refactor("Extract Function To File")
        end,
        mode = "v",
        desc = "Extract Function To File",
      },
      {
        "<leader>ri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = { "n", "v" },
        desc = "Inline Variable",
      },
      {
        "<leader>rb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        desc = "Extract Block",
      },
      {
        "<leader>rp",
        function()
          require("refactoring").debug.print_var({ normal = true })
        end,
        desc = "Debug Print Variable",
      },
      {
        "<leader>rP",
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        desc = "Debug Print",
      },
      {
        "<leader>rc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        desc = "Debug Cleanup",
      },
      {
        "<leader>rx",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "v",
        desc = "Extract Variable",
      },
    },
    opts = {},
  },

  -- -- Better increase/descrease
  -- {
  --   "monaqa/dial.nvim",
  --   -- stylua: ignore
  --   keys = {
  --     { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
  --     { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
  --   },
  --   config = function()
  --     local augend = require("dial.augend")
  --     require("dial.config").augends:register_group({
  --       default = {
  --         augend.integer.alias.decimal,
  --         augend.integer.alias.hex,
  --         augend.date.alias["%Y/%m/%d"],
  --         augend.constant.alias.bool,
  --         augend.semver.alias.semver,
  --         augend.constant.new({ elements = { "let", "const" } }),
  --       },
  --     })
  --   end,
  -- },

  -- {
  --   "simrat39/symbols-outline.nvim",
  --   keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
  --   cmd = "SymbolsOutline",
  --   opts = {
  --     position = "right",
  --   },
  -- },

  {
    "mg979/vim-visual-multi",
  },
}
