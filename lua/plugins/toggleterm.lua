return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({})
    vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>")
    vim.keymap.set("t", "<leader>tt", "<C-\\><C-n>:ToggleTerm<CR>")
  end,
}
