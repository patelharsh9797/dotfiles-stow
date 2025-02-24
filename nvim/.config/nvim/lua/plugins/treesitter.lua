return {
  -- { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      rainbow = {
        enable = true,
        -- Which query to use for finding delimiters
        query = "rainbow-parens",
        -- Highlight the entire buffer all at once
        strategy = require("rainbow-delimiters").strategy.global,
        -- list of languages you want to disable the plugin for
        -- disable = { "jsx", "cpp" },
        -- Which query to use for finding delimiters
        -- query = "rainbow-parens",
        -- Highlight the entire buffer all at once
        -- strategy = require("ts-rainbow").strategy.global,
      },
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "dockerfile",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "gitignore",
        "http",
        "scss",
        "prisma",
      },
      highlight = { enable = true },
      indent = { enable = true },
      -- matchup = {
      -- 	enable = true,
      -- },

      -- https://github.com/nvim-treesitter/playground#query-linter
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
    config = function(_, opts)
      -- require("nvim-treesitter.parsers").get_parser_configs().caddy = {
      --   install_info = {
      --     url = "https://github.com/Samonitari/tree-sitter-caddy",
      --     files = { "src/parser.c", "src/scanner.c" },
      --     branch = "master",
      --   },
      --   filetype = "caddy",
      -- }

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })

      -- vim.filetype.add({
      --   pattern = {
      --     ["Caddyfile"] = "caddy",
      --   },
      -- })

      vim.treesitter.language.register("markdown", "mdx")

      -- vim.list_extend(opts.ensure_installed, {
      --   "caddy",
      -- })

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
