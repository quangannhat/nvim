--Options
local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.mouse = "a"
opt.showmode = false

opt.termguicolors = true

opt.cursorline = true

--search
opt.ignorecase = true
opt.smartcase = true

opt.breakindent = true

opt.signcolumn = "yes"

opt.updatetime = 250

opt.timeoutlen = 300

opt.scrolloff = 15

-- sync with system's clipboard
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

--Leader key, key mapping
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

--turn off search highlight
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
--turn off insert mode
keymap.set("i", "jj", "<Esc>")

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

--Highlight when yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})
