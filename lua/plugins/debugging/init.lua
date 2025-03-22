return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
  },
  config = function()
    require("plugins.debugging.setup")
    require("plugins.debugging.keymaps")
    require("plugins.debugging.go")
    require("plugins.debugging.js")
  end,
}
