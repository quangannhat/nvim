return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "right",
        number = true,
        relativenumber = true,
      },
    })

    vim.keymap.set("n", "\\", ":NvimTreeToggle<CR>", {
      noremap = true,
      silent = true,
      desc = "Toggle NvimTree",
    })
    --open on load
    vim.cmd("NvimTreeOpen")
  end,
}
