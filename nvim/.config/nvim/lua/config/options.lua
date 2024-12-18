-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt -- for conciseness

opt.inccommand = "split" -- rename show seprate window

opt.pumblend = 0 -- transperent BG for suggestion and hover docs

opt.clipboard = "unnamedplus" -- allow access to system clipboard

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- f3fora/cmp-spell
opt.spell = true
opt.spelllang = { "en_us" }

-- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "pylsp"
vim.g.lazyvim_python_ruff = "ruff"

-- LazyVim auto format
vim.g.autoformat = true

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = true

-- LazyVim picker to use.
-- Can be one of: telescope, fzf || auto
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = "fzf"

-- LazyVim completion engine to use.
-- Can be one of: nvim-cmp, blink.cmp || auto
-- Leave it to "auto" to automatically use the completion engine
-- enabled with `:LazyExtras`
vim.g.lazyvim_cmp = "nvim-cmp"

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
vim.g.ai_cmp = false

-- Hide deprecation warnings
vim.g.deprecation_warnings = false
