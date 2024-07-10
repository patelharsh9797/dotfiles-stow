return {
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        animation = function()
          return 0
        end,
      },
    },
  },
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

      icons.setup({
        file = {
          ["docker-compose.yml"] = dockerfile_icon_tbl,
          ["docker-compose.dev.yml"] = dockerfile_icon_tbl,
          ["docker-compose.prod.yml"] = dockerfile_icon_tbl,
          ["docker-compose.base.yml"] = dockerfile_icon_tbl,
        },
        extension = {
          db = database_icon_tbl,
        },
      })
    end,
  },
  -- {
  -- 	"lukas-reineke/indent-blankline.nvim",
  -- 	main = "ibl",
  -- 	config = function()
  -- 		local highlight = {
  -- 			"RainbowRed",
  -- 			"RainbowYellow",
  -- 			"RainbowBlue",
  -- 			"RainbowOrange",
  -- 			"RainbowGreen",
  -- 			"RainbowViolet",
  -- 			"RainbowCyan",
  -- 		}
  -- 		local hooks = require("ibl.hooks")
  -- 		-- create the highlight groups in the highlight setup hook, so they are reset
  -- 		-- every time the colorscheme changes
  -- 		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  -- 			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  -- 			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  -- 			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  -- 			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  -- 			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  -- 			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  -- 			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  -- 		end)
  --
  -- 		vim.g.rainbow_delimiters = { highlight = highlight }
  -- 		require("ibl").setup({
  -- 			scope = { highlight = highlight },
  -- 			exclude = { filetypes = { "dashboard", "toggleterm" } },
  -- 		})
  --
  -- 		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  -- 	end,
  -- },
  -- {
  -- 	"HiPhish/rainbow-delimiters.nvim",
  -- 	config = function()
  -- 		local rainbow_delimiters = require("rainbow-delimiters")
  --
  -- 		vim.g.rainbow_delimiters = {
  -- 			strategy = {
  -- 				[""] = rainbow_delimiters.strategy["global"],
  -- 				commonlisp = rainbow_delimiters.strategy["local"],
  -- 			},
  -- 			query = {
  -- 				[""] = "rainbow-delimiters",
  -- 				lua = "rainbow-blocks",
  -- 			},
  -- 			highlight = {
  -- 				"RainbowDelimiterRed",
  -- 				"RainbowDelimiterYellow",
  -- 				"RainbowDelimiterBlue",
  -- 				"RainbowDelimiterOrange",
  -- 				"RainbowDelimiterGreen",
  -- 				"RainbowDelimiterViolet",
  -- 				"RainbowDelimiterCyan",
  -- 			},
  -- 			blacklist = {},
  -- 		}
  -- 	end,
  -- },
}
