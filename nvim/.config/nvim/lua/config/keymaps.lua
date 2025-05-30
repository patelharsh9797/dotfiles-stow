---@diagnostic disable: no-unknown
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local discipline = require("harsh.discipline")
discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "st", "saatt", {
  remap = true,
  desc = "Surround Tag with another Tag",
})

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
-- keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

keymap.set("n", "<Leader>xs", ":source %<Return>", { desc = "Source curent file" })

keymap.set("n", "G", "GGzz") -- End page down but still stay in the center

-- ThePrimeagen Keymaps
keymap.set("n", "<C-d>", "<C-d>zz") -- Half page down
keymap.set("n", "<C-u>", "<C-u>zz") -- Half page up
keymap.set("n", "n", "nzzzv") -- Search next & center
keymap.set("n", "N", "Nzzzv") -- Search previous & center

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit<Return>", { desc = "Open new tab" }) -- Open new tab
keymap.set("n", "<tab>", ":tabnext<Return>", opts) -- Next Tab
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts) -- Previous Tab
keymap.set("n", "tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab

-- Split window
keymap.set("n", "ss", ":split<Return>", opts) -- split window vertically
keymap.set("n", "sv", ":vsplit<Return>", opts) -- split window horizontally
keymap.set("n", "se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- -- Diagnostics
-- keymap.set("n", "<C-j>", function()
--   vim.diagnostic.goto_next()
-- end, opts)

-- keymap.set("n", "<leader>r", function()
--   require("harsh.hsl").replaceHexWithHSL()
-- end)
--
-- keymap.set("n", "<leader>i", function()
--   require("harsh.lsp").toggleInlayHints()
-- end)
