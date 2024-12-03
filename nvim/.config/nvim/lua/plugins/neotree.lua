return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "right",
      mappings = {
        ["Y"] = "none",
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
          ".DS_Store",
        },
        always_show = {
          ".gitignored",
        },
        always_show_by_pattern = {
          ".env*",
          ".docker*",
        },
      },
    },
  },
}
