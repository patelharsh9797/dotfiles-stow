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

-- disable animations
vim.g.snacks_animate = false

-- lazyvim v14 update fixes
vim.g.lazyvim_cmp = "nvim-cmp"
vim.g.lazyvim_picker = "telescope"
