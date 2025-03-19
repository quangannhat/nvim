return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
    config = function()
      local git_sign = require("gitsigns")
      git_sign.setup({})

      vim.keymap.set("n", "gt", ":Gitsigns toggle_current_line_blame<CR>", {
        desc = "Toggle current line blame",
        silent = true,
      })
    end,
  },
}
