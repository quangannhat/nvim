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

opt.updatetime = 100

opt.timeoutlen = 3000

opt.scrolloff = 10

opt.swapfile = false

-- sync with system's clipboard
-- vim.schedule(function()
--   vim.opt.clipboard = "unnamedplus"
-- end)

--Leader key, key mapping
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

--turn off search highlight
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys in normal mode
keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

--centering after move up/down half of the screen
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

--move stuff up/down during visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

keymap.set("v", "<leader>y", '"+y')

--quick fix
keymap.set("n", "<C-M-j>", "<cmd>:cnext<CR>")
keymap.set("n", "<C-M-k>", "<cmd>:cprev<CR>")

--Auto increment
keymap.set("v", "<leader>a", "g<C-a>", { silent = true })

--Highlight when yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typescriptreact", -- filetype for .tsx
  callback = function()
    local macros = require("macros.tsx")
    vim.fn.setreg("r", macros.remove_wrapper)

    vim.fn.setreg("p", macros.export_default)

    vim.fn.setreg("a", macros.add_wrapper)
  end,
  once = true,
})
