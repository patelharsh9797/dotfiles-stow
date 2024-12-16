return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = {},
  keys = {
    {
      "<C-p>",
      function()
        require("fzf-lua").files()
      end,
      desc = "Lists files in your current working directory",
    },
    {
      ";f",
      function()
        require("fzf-lua").files()
      end,
      desc = "Lists files in your current working directory",
    },
    {
      ";r",
      function()
        require("fzf-lua").live_grep({ additional_opts = { "--hidden" } })
      end,
      desc = "Search for a string in the current working directory",
    },
    {
      ";;",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Resume the previous fzf-lua picker",
    },
    {
      "\\\\",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Lists open buffers",
    },
    {
      ";t",
      function()
        require("fzf-lua").helptags()
      end,
      desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
    },
    {
      ";e",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "Lists Diagnostics For Current Buffers",
    },
    {
      ";E",
      function()
        require("fzf-lua").diagnostics_workspace()
      end,
      desc = "Lists Diagnostics For Workshop",
    },
    {
      ";s",
      function()
        require("fzf-lua").spell_suggest()
      end,
      desc = "Lists spell suggestions",
    },
    {
      ";S",
      function()
        require("fzf-lua").treesitter()
      end,
      desc = "Lists Function names, variables, from Treesitter",
    },
  },
  config = function()
    require("fzf-lua").setup({})
  end,
}
