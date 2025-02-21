return {
  --sueprmaven
  {
    enabled = true,
    "supermaven-inc/supermaven-nvim",
  },

  -- codeium.vim
  {
    enabled = false,
    "Exafunction/codeium.vim",
    event = "BufEnter",
    -- config = function()
    --   -- Change '<C-g>' here to any keycode you like.
    --   vim.keymap.set("i", "<M-a>", function()
    --     return vim.fn["codeium#Accept"]()
    --   end, { expr = true, silent = true })
    --   vim.keymap.set("i", "<c-;>", function()
    --     return vim.fn["codeium#CycleCompletions"](1)
    --   end, { expr = true, silent = true })
    --   vim.keymap.set("i", "<c-,>", function()
    --     return vim.fn["codeium#CycleCompletions"](-1)
    --   end, { expr = true, silent = true })
    --   vim.keymap.set("i", "<c-x>", function()
    --     return vim.fn["codeium#Clear"]()
    --   end, { expr = true, silent = true })
    -- end,
  },
  -- codeium.nvim
  -- {
  --   "Exafunction/codeium.nvim",
  --   cmd = "Codeium",
  --   build = ":Codeium Auth",
  --   opts = function(_, opts)
  --     opts.enable_cmp_source = vim.g.ai_cmp
  --     opts.virtual_text = {
  --       enabled = not vim.g.ai_cmp,
  --       key_bindings = {
  --         accept = false, -- handled by nvim-cmp / blink.cmp
  --         next = "<M-]>",
  --         prev = "<M-[>",
  --       },
  --     }
  --
  --     LazyVim.cmp.actions.ai_accept = function()
  --       if require("codeium.virtual_text").get_current_completion_item() then
  --         LazyVim.create_undo()
  --         vim.api.nvim_input(require("codeium.virtual_text").accept())
  --         return true
  --       end
  --     end
  --   end,
  -- },

  -- supermaven
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({
  --       keymaps = {
  --         accept_suggestion = "<C-Right>",
  --         clear_suggestion = "<C-]>",
  --         accept_word = "<C-j>",
  --       },
  --       ignore_filetypes = { cpp = true }, -- or { "cpp", }
  --       color = {
  --         suggestion_color = "#a0a0a0",
  --         cterm = 244,
  --       },
  --       log_level = "info", -- set to "off" to disable logging completely
  --       disable_inline_completion = false, -- disables inline completion for use with cmp
  --       disable_keymaps = false, -- disables built in keymaps for more manual control
  --       condition = function()
  --         return false
  --       end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
  --     })
  --   end,
  -- },
}
