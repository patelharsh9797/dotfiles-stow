return {
  {
    "vuki656/package-info.nvim",
    ft = "json",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("package-info").setup({
        autostart = false, -- Whether to autostart when `package.json` is opened
        package_manager = "bun",
        colors = {
          -- outdated = "#db4b4b",
          up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
          outdated = "#d19a66", -- Text color for outdated dependency virtual text
          invalid = "#ee4b2b", -- Text color for invalid dependency virtual text
        },
        icons = {
          enable = true, -- Whether to display icons
          style = {
            up_to_date = "|  ", -- Icon for up to date dependencies
            outdated = "|  ", -- Icon for outdated dependencies
            invalid = "|  ", -- Icon for invalid dependencies
          },
        },
        hide_up_to_date = true,
      })
    end,
  },
}
