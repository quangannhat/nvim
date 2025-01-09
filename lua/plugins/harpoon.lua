return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      local prefix_key = "<C-h>"
      harpoon:setup()
      vim.keymap.set("n", prefix_key .. "a", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", prefix_key .. "o", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      for i = 1, 5 do
        vim.keymap.set("n", prefix_key .. i, function()
          harpoon:list():select(i)
        end)
      end
    end,
  },
}
