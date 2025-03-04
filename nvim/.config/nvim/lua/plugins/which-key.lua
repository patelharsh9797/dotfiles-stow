return {
  "folke/which-key.nvim",
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "helix",
    delay = 0,
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    -- popup_mappings = {
    --   scroll_down = "<c-d>", -- binding to scroll down inside the popup
    --   scroll_up = "<c-u>", -- binding to scroll up inside the popup
    -- },
    wo = {
      border = "rounded", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
      padding = { 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      zindex = 1000, -- positive value to position WhichKey above other floating windows.
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    -- Document existing key chains
    spec = {
      {
        "<leader>o",
        group = "Overseer",
        icon = { icon = "", color = "red" },
      },
    },
  },
}
