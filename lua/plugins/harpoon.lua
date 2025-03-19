return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<C-h>", function()
        print("Added a file to harpoon")
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<C-M-h>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      for i = 1, 5 do
        vim.keymap.set("n", "<C-" .. i .. ">", function()
          harpoon:list():select(i)
        end)
      end
    end,
  },
}
