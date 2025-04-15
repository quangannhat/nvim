local dap = require("dap")
local dapui = require("dapui")

local keymap = vim.keymap
keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
keymap.set("n", "<leader>dut", dapui.toggle)

keymap.set("n", "<F8>", dap.continue)
keymap.set("n", "<F9>", dap.step_back)
keymap.set("n", "<F10>", dap.step_into)
keymap.set("n", "<F11>", dap.step_over)
keymap.set("n", "<F10>", dap.step_out)
