return {
  "stevearc/oil.nvim",
  dependencies = {
    {
      "echasnovski/mini.icons",
      opts = {},
    },
  },
  config = function()
    local view_options = {
      show_hidden = true,
    }
    local keymaps = {
      ["<C-h>"] = false,
    }
    require("oil").setup({
      view_options = view_options,
      keymaps,
    })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>")
    vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
  end,
}
