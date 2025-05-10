-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.g.rainbow_delimiters = { query = { tsx = "rainbow-parens", jsx = "rainbow-parens" } }
vim.g.tpipeline_clearstl = 1
vim.g.tpipeline_autoembed = 1
vim.g.tpipeline_restore = 1

-- some transperent effect
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Use spelling for markdown files ‘]s’ to find next, ‘[s’ for previous, 'z=‘ for suggestions when on one.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- attach docker-compose lsp to file pattern docker-compose*.yml
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "compose*.yml", "compose*.yaml", "docker-*.yml", "docker-*.yaml" },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
})

-- attach gitlab-ci lsp to file pattern .gitlab-ci.yml
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".gitlab-ci.yml", ".gitlab-ci.yaml" },
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "package.json" },
  callback = function()
    local picker = require("util.package-info-picker")
    vim.keymap.set("n", "<leader>cp", picker.package_info_picker, {
      silent = true,
      noremap = true,
      desc = "Pick package-info action",
    })
  end,
})
