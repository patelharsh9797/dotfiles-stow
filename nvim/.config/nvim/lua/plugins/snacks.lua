---@diagnostic disable: duplicate-doc-field, duplicate-set-field
local M = {}

M.exclude = {
  ".git",
  ".next",
  "node_modules",
  ".yarn",
  ".pnpm-store",
  ".venv",
  -- "env/",
  ".env/",
  "venv",
  "__pycache__",
}

M.include = { ".env*", ".github", ".gitlab-ci.yml", ".gitignore", "**eslint*", "**prettierrc*", ".dockerignore" }

M.files_and_grep = {
  hidden = true,
  ignored = true,
  include = M.include,
  exclude = M.exclude,
}

M.layout = {
  { preview = true },
  layout = {
    box = "horizontal",
    width = 0.8,
    height = 0.8,
    {
      box = "vertical",
      border = "rounded",
      title = "{source} {live} {flags}",
      title_pos = "center",
      { win = "input", height = 1, border = "bottom" },
      { win = "list", border = "none" },
    },
    { win = "preview", border = "rounded", width = 0.6, title = "{preview}" },
  },
}

M.vscode_layout = {
  preview = false,
  layout = {
    backdrop = false,
    row = 3,
    width = 0.5,
    min_width = 80,
    height = 0.8,
    border = "rounded",
    box = "vertical",
    { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
    { win = "list", border = "none" },
    { win = "preview", title = "{preview}", border = "rounded" },
  },
}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    ---@class snacks.dashboard.Config
    ---@field sections snacks.dashboard.Section
    ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
    dashboard = {
      width = 60,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your custom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- Used by the `header` section
        header = [[

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      -- item field formatters
      sections = {
        { section = "header" },
        {
          pane = 2,
          section = "terminal",
          cmd = "colorscript -e square",
          height = 5,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 2,
        },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
        -- {
        --   pane = 2,
        --   icon = " ",
        --   title = "Git Status",
        --   section = "terminal",
        --   enabled = function()
        --     return Snacks.git.get_root() ~= nil
        --   end,
        --   cmd = "hub status --short --branch --renames",
        --   height =
        --   padding = 1,
        --   ttl = 5 * 60,
        --   indent = 3,
        -- },
        { section = "startup" },
      },
    },
    explorer = {
      enabled = true,
    },
    image = {
      enabled = true,
      doc = {
        -- Personally I set this to false, I don't want to render all the
        -- images in the file, only when I hover over them
        -- render the image inline in the buffer
        -- if your env doesn't support Unicode placeholders, this will be disabled
        -- takes precedence over `opts.float` on supported terminals
        inline = vim.g.neovim_mode == "skitty" and true or false,
        -- only_render_image_at_cursor = vim.g.neovim_mode == "skitty" and false or true,
        -- render the image in a floating window
        -- only used if `opts.inline` is disabled
        float = true,
        -- Sets the size of the image
        -- max_width = 60,
        max_width = vim.g.neovim_mode == "skitty" and 20 or 60,
        max_height = vim.g.neovim_mode == "skitty" and 10 or 30,
        -- max_height = 30,
        -- Apparently, all the images that you preview in neovim are converted
        -- to .png and they're cached, original image remains the same, but
        -- the preview you see is a png converted version of that image
        --
        -- Where are the cached images stored?
        -- This path is found in the docs
        -- :lua print(vim.fn.stdpath("cache") .. "/snacks/image")
        -- For me returns `~/.cache/neobean/snacks/image`
        -- Go 1 dir above and check `sudo du -sh ./* | sort -hr | head -n 5`
      },
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      debug = {
        scores = false,
      },
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        -- the bonusses below, possibly require string concatenation and path normalization,
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = false, -- give bonus for matching files in the cwd
        frecency = true, -- frecency bonus
        history_bonus = false, -- give more weight to chronological order
      },
      sources = {
        files = M.files_and_grep,
        grep = M.files_and_grep,
        explorer = {
          include = M.include,
          exclude = M.exclude,
          auto_close = true,
          -- layout = { layout = { position = "right" } },
          layout = M.layout,
          win = {
            list = {
              keys = { ["<Right>"] = "confirm", ["<Left>"] = "explorer_close" },
              wo = {
                number = false, -- Enable line numbers
                relativenumber = false, -- Enable relative line numbers
              },
            },
          },
        },
      },
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
    words = { enabled = true },
  },
  keys = {
    -- -- Iterate through incomplete tasks in Snacks_picker
    -- {
    --   -- -- You can confirm in your teminal lamw26wmal with:
    --   -- -- rg "^\s*-\s\[ \]" test-markdown.md
    --   "<leader>tt",
    --   function()
    --     Snacks.picker.grep({
    --       -- prompt = " ",
    --       -- pass your desired search as a static pattern
    --       search = "^\\s*- \\[ \\]",
    --       -- we enable regex so the pattern is interpreted as a regex
    --       regex = true,
    --       -- no “live grep” needed here since we have a fixed pattern
    --       live = false,
    --       -- restrict search to the current working directory
    --       dirs = { vim.fn.getcwd() },
    --       -- include files ignored by .gitignore
    --       args = { "--no-ignore" },
    --       -- Start in normal mode
    --       on_show = function()
    --         vim.cmd.stopinsert()
    --       end,
    --       finder = "grep",
    --       format = "file",
    --       show_empty = true,
    --       supports_live = false,
    --       layout = M.layout,
    --     })
    --   end,
    --   desc = "[P]Search for incomplete tasks",
    -- },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },

    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>ba",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit Snacks",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = "which_key_ignore",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },

    -- Snacks picker keymap updates like fzf
    {
      ";f",
      function()
        Snacks.picker.files({
          layout = M.layout,
        })
      end,
      desc = "Find Files",
    },
    {
      ";p",
      function()
        Snacks.picker.projects({
          layout = M.layout,
        })
      end,
      desc = "Projects",
    },
    {
      ";c",
      function()
        Snacks.picker.files({
          cwd = vim.fn.stdpath("config"),
          layout = M.layout,
        })
      end,
      desc = "Lazyvim Config Files",
    },
    {
      ";b",
      function()
        Snacks.picker.grep_buffers({
          layout = M.layout,
        })
      end,
      desc = "Search In Open Buffer",
    },
    {
      ";l",
      function()
        Snacks.picker.lines({
          layout = M.vscode_layout,
        })
      end,
      desc = "Search lines in the current buffer",
    },
    {
      ";g",
      function()
        Snacks.picker.git_files({
          layout = M.layout,
        })
      end,
      desc = "Find Git Files",
    },
    {
      ";r",
      function()
        Snacks.picker.grep({
          layout = M.layout,
        })
      end,
      desc = "Grep",
    },
    {
      ";R",
      function()
        Snacks.picker.recent({ filter = { cwd = true }, layout = M.layout })
      end,
      desc = "Recent (cwd)",
    },
    {
      ";q",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      ";k",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      ";t",
      function()
        Snacks.picker.help({
          layout = M.layout,
        })
      end,
      desc = "Help Pages",
    },
    {
      ";d",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      ";s",
      function()
        ---@diagnostic disable-next-line: undefined-field
        Snacks.picker.spelling({
          finder = "vim_spelling",
          format = "text",
          layout = { preset = "select" },
          confirm = "item_action",
        })
      end,
      desc = "Spelling",
    },
    {
      "\\\\",
      function()
        Snacks.picker.buffers({
          layout = M.layout,
        })
      end,
      desc = "Buffers",
    },
    {
      ";;",
      function()
        Snacks.picker.resume({
          layout = M.layout,
        })
      end,
      desc = "Resume",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end,
    })
  end,
}
