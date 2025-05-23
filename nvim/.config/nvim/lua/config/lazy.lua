local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        news = {
          lazyvim = true,
          neovim = true,
        },
      },
    },
    -- import any extras modules here

    { import = "lazyvim.plugins.extras.ai.supermaven" },
    { import = "lazyvim.plugins.extras.coding.luasnip" },
    -- { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
    -- { import = "lazyvim.plugins.extras.coding.blink" },

    { import = "lazyvim.plugins.extras.editor.inc-rename" },
    -- { import = "lazyvim.plugins.extras.editor.refactoring" },
    -- { import = "lazyvim.plugins.extras.editor.telescope" },
    -- { import = "lazyvim.plugins.extras.editor.fzf" },
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },

    { import = "lazyvim.plugins.extras.formatting.prettier" },

    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.prisma" },
    -- { import = "lazyvim.plugins.extras.lang.python" }, -- disable cause auto install of pyright
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    -- { import = "lazyvim.plugins.extras.lang.typescript" }, -- disable cause auto install of vtsls
    { import = "lazyvim.plugins.extras.lang.yaml" },

    { import = "lazyvim.plugins.extras.linting.eslint" },

    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    --{ import = "lazyvim.plugins.extras.ui.mini-animate" },

    { import = "lazyvim.plugins.extras.util.dot" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

    { import = "lazyvim.plugins.extras.vscode" },

    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  ui = {
    size = { width = 0.8, height = 0.8 },
    title = nil, ---@type string only works when border is not "none"
    title_pos = "center", ---@type "center" | "left" | "right"
    wrap = true, -- wrap the lines in the ui
    -- Show pills on top of the Lazy window
    pills = true, ---@type boolean
    border = "rounded",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
