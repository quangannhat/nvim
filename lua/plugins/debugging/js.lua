local port = 8123
local path = vim.fn.expand("~" .. "~/debuggers/js-debug/src/dapDebugServer.js")

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = port,
  executable = {
    command = "node",
    args = { path, port },
  },
}

for _, lang in ipairs({ "javascript", "typescript" }) do
  require("dap").configurations[lang] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
  }
end
