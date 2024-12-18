---@diagnostic disable: undefined-doc-name
return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  keys = {
    { "<M-p>", "<cmd>Oil<cr>", desc = "Oil" },
  },
  config = function()
    require("oil").setup({
      default_file_explorer = false,
      -- delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      win_options = {
        wrap = true,
      },
    })
  end,
}
