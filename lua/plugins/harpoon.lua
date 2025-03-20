return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      local fidget = require("fidget")
      vim.keymap.set("n", "<C-M-a>", function()
        local file_name = vim.fn.expand("%:t")
        fidget.notify("Added " .. file_name .. " to harpoon", nil, {
          ttl = 1,
        })
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<C-M-h>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      for i = 1, 5 do
        vim.keymap.set("n", "<F" .. i .. ">", function()
          local entry = harpoon:list():get(i)
          if not entry then
            fidget.notify("No files attached to slot " .. i, nil, {
              ttl = 1,
            })
          end
          harpoon:list():select(i)
        end)
      end
    end,
  },
}
