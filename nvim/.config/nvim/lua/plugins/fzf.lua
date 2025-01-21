return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "echasnovski/mini.icons" },
  config = function(_, opts)
    require("fzf-lua").setup({
      fzf_colors = true,

      -- for horizontal layout at bottom.
      -- winopts = vim.tbl_extend("force", opts.winopts or {}, {
      -- border = "rounded",
      -- width = 0.85,
      -- height = 0.80,
      -- row = 1, -- window row position (0=top, 1=bottom)
      -- background = 100, -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
      preview = {
        wrap = "wrap", -- wrap|nowrap
        --   horizontal = "right:60%",
      },
      -- }),
    })
  end,
  keys = {
    -- {
    --   "<C-p>",
    --   function()
    --     require("fzf-lua").files()
    --   end,
    --   desc = "Lists files in your current working directory",
    -- },
    {
      ";f",
      function()
        require("fzf-lua").files()
      end,
      desc = "Lists files in your current working directory",
    },
    {
      ";c",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Neovim Config Files",
    },
    {
      ";p",
      LazyVim.pick("files", { cwd = require("lazy.core.config").options.root }),
      desc = "Find Plugin File",
    },
    {
      ";P",
      function()
        local dirs = { "~/dot/nvim/lua/plugins", "~/projects/LazyVim/lua/lazyvim/plugins" }
        require("fzf-lua").live_grep({
          filespec = "-- " .. table.concat(vim.tbl_values(dirs), " "),
          search = "/",
          formatter = "path.filename_first",
        })
      end,
      desc = "Find Plugin File",
    },

    {
      ";r",
      function()
        require("fzf-lua").live_grep({ additional_opts = { "--hidden" } })
      end,
      desc = "Search for a string in the current working directory",
    },
    {
      ";q",
      require("fzf-lua").quickfix,
      desc = "Lists quickfix list",
    },
    {
      ";b",
      function()
        require("fzf-lua").builtin()
      end,
      desc = "Lists keymaps",
    },
    {
      ";k",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "Lists keymaps",
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
    {
      "\\\\",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Lists open buffers",
    },
    {
      ";;",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Resume the previous fzf-lua picker",
    },
  },
}
