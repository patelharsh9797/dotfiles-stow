return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    default_component_configs = {
      icon = {
        provider = function(icon, node) -- setup a custom icon provider
          local text, hl
          local mini_icons = require("mini.icons")
          if node.type == "file" then -- if it's a file, set the text/hl
            text, hl = mini_icons.get("file", node.name)
          elseif node.type == "directory" then -- get directory icons
            text, hl = mini_icons.get("directory", node.name)
            -- only set the icon text if it is not expanded
            if node:is_expanded() then
              text = nil
            end
          end

          -- set the icon text/highlight only if it exists
          if text then
            icon.text = text
          end
          if hl then
            icon.highlight = hl
          end
        end,
      },
      kind_icon = {
        provider = function(icon, node)
          local mini_icons = require("mini.icons")
          icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
        end,
      },
    },
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
          "node_modules",
        },
        always_show = {
          ".config",
          ".gitignore",
        },
        always_show_by_pattern = {
          ".env*",
          ".docker*",
        },
      },
    },
  },
}
