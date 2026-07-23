local opt = vim.opt

opt.termguicolors = true

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 10

opt.ignorecase = true
opt.smartcase = true

opt.breakindent = true

opt.signcolumn = "yes"

opt.updatetime = 100

opt.timeoutlen = 3000

opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.smartindent = true
opt.autoindent = true

opt.foldmethod = "expr"                          -- use expression for folding
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
opt.foldlevel = 99                               -- start with all folds open

opt.signcolumn = "yes"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

--turn off search highlight
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys in normal mode
keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

--centering after move up/down half of the screen
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")


--move stuff up/down during visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

keymap.set("v", "<leader>y", '"+y')

keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

--quick fix
keymap.set("n", "<C-M-j>", "<cmd>:cnext<CR>")
keymap.set("n", "<C-M-k>", "<cmd>:cprev<CR>")

local function copy_file_path(opts)
  local path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
  local ref
  if opts and opts.range and opts.range > 0 and opts.line1 ~= opts.line2 then
    ref = path .. ":" .. opts.line1 .. "-" .. opts.line2
  else
    ref = path .. ":" .. vim.fn.line(".")
  end
  vim.fn.setreg("+", ref)
  print("file:", ref)
end

keymap.set("n", "<leader>pa", copy_file_path, { desc = "Copy file path with line" })
keymap.set("x", "<leader>pa", function()
  local l1, l2 = vim.fn.line("v"), vim.fn.line(".")
  if l1 > l2 then
    l1, l2 = l2, l1
  end
  copy_file_path({ range = 1, line1 = l1, line2 = l2 })
end, { desc = "Copy file path with line range" })
vim.api.nvim_create_user_command("CopyFilePath", copy_file_path, { range = true })

keymap.set('n', '<leader>*', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true })

keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

--Highlight when yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  desc = "Restore last cursor position",
  callback = function()
    if vim.o.diff then -- except in diff mode
      return
    end

    local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
    local last_line = vim.api.nvim_buf_line_count(0)

    local row = last_pos[1]
    if row < 1 or row > last_line then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  end,
})


vim.pack.add({
  "https://github.com/catppuccin/nvim",
  "https://www.github.com/ibhagwan/fzf-lua",
  "https://www.github.com/nvim-tree/nvim-tree.lua",
  "https://www.github.com/echasnovski/mini.nvim",
  "https://www.github.com/lewis6991/gitsigns.nvim",
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
  "https://www.github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/windwp/nvim-ts-autotag",
  {
    src = 'https://github.com/JavaHello/spring-boot.nvim',
    version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
  },
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',

  'https://github.com/nvim-java/nvim-java',
  "https://github.com/akinsho/toggleterm.nvim",
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
})

vim.cmd.colorscheme("catppuccin")

local function packadd(name)
  vim.cmd("packadd " .. name)
end

packadd("conform.nvim")
packadd("nvim-tree.lua")
packadd("fzf-lua")
packadd("mini.nvim")
packadd("gitsigns.nvim")
packadd("nvim-treesitter")
packadd("oil.nvim")
packadd("nvim-ts-autotag")
packadd("lualine.nvim")
packadd("toggleterm.nvim")
packadd("vim-dadbod")
packadd("vim-dadbod-ui")
packadd("vim-dadbod-completion")

vim.g.dbs = {
  { name = "arbinxdata_1",            url = "postgresql://postgres:arbin@localhost:5432/arbinxdata_1" },
  { name = "arbinxinfo_1",            url = "postgresql://postgres:arbin@localhost:5432/arbinxinfo_1" },
  { name = "arbin_log_v1",            url = "postgresql://postgres:arbin@localhost:5432/arbin_log_v1" },
  { name = "arbinxmasterinfo",        url = "postgresql://postgres:arbin@localhost:5432/arbinxmasterinfo" },
  { name = "ArbinProfileDatabase",    url = "postgresql://postgres:arbin@localhost:5432/ArbinProfileDatabase" },
  { name = "ArbinTestSimulationDatabase", url = "postgresql://postgres:arbin@localhost:5432/ArbinTestSimulationDatabase" },
  { name = "sqlite_arbinxdata_1",     url = "sqlite:///home/quangan/dev/arbin/test-output/sqlite-dbs/InitAllDb_CreatesCoreTablesInEachFile/arbinxdata_1.db" },
}

--LSP
packadd("nvim-lspconfig")
packadd("mason.nvim")

require("nvim-tree").setup({
  view = {
    width = 35,
  },
  filters = {
    dotfiles = false,
  },
  renderer = {
    group_empty = false,
  },
})

require("oil").setup()
require("lualine").setup()
require("toggleterm").setup({
  direction = "float",
  float_opts = {
    border = "curved",
  },
})

keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<cr>', { desc = "Toggle terminal" })

require("nvim-ts-autotag").setup({})

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle nvim tree" })

require("fzf-lua").setup({})

keymap.set("n", "<leader>ff", function()
  require("fzf-lua").files()
end)

keymap.set("n", "<leader>fg", function()
  require("fzf-lua").live_grep()
end)

keymap.set("n", "<leader>fb", function()
  require("fzf-lua").buffers()
end)

keymap.set("n", "<leader>fx", function()
  require("fzf-lua").diagnostics_document()
end)

keymap.set("n", "<leader>fX", function()
  require("fzf-lua").diagnostics_workspace()
end)

keymap.set("n", "<leader>fn", function()
  require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find neovim config files" })

require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.surround").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})


require("gitsigns").setup({
  signs = {
    add = { text = "\u{2590}" },          -- ▏
    change = { text = "\u{2590}" },       -- ▐
    delete = { text = "\u{2590}" },       -- ◦
    topdelete = { text = "\u{25e6}" },    -- ◦
    changedelete = { text = "\u{25cf}" }, -- ●
    untracked = { text = "\u{25cb}" },    -- ○
  },
  signcolumn = true,
  current_line_blame = false,
})

keymap.set("n", "gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", {
  desc = "Toggle current line blame",
  silent = true,
})

local setup_treesitter = function()
  local treesitter = require("nvim-treesitter")
  treesitter.setup({})
  local ensure_installed = {
    "vim",
    "vimdoc",
    "c",
    "go",
    "html",
    "css",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "typescript",
    "tsx",
    "bash",
  }

  local config = require("nvim-treesitter.config")

  local already_installed = config.get_installed()
  local parsers_to_install = {}

  for _, parser in ipairs(ensure_installed) do
    if not vim.tbl_contains(already_installed, parser) then
      table.insert(parsers_to_install, parser)
    end
  end

  if #parsers_to_install > 0 then
    treesitter.install(parsers_to_install)
  end

  local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
        vim.treesitter.start(args.buf)
      end
    end,
  })
end

setup_treesitter()

--LSP

local diagnostic_signs = {
  Error = " ",
  Warn = " ",
  Hint = "",
  Info = "",
}

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
})

do
  local orig = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig(contents, syntax, opts, ...)
  end
end

local function lsp_on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then
    return
  end

  local bufnr = ev.buf
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gd", function()
    require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
  end, opts)

  vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)

  vim.keymap.set("n", "gS", function()
    vim.cmd("vsplit")
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  vim.keymap.set("n", "<leader>D", function()
    vim.diagnostic.open_float({ scope = "line" })
  end, opts)
  vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float({ scope = "cursor" })
  end, opts)
  vim.keymap.set("n", "<leader>nd", function()
    vim.diagnostic.jump({ count = 1 })
  end, opts)

  vim.keymap.set("n", "<leader>pd", function()
    vim.diagnostic.jump({ count = -1 })
  end, opts)

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  vim.keymap.set("n", "<leader>fd", function()
    require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
  end, opts)
  vim.keymap.set("n", "<leader>fr", function()
    require("fzf-lua").lsp_references()
  end, opts)
  vim.keymap.set("n", "<leader>ft", function()
    require("fzf-lua").lsp_typedefs()
  end, opts)
  vim.keymap.set("n", "<leader>fs", function()
    require("fzf-lua").lsp_document_symbols()
  end, opts)
  vim.keymap.set("n", "<leader>fw", function()
    require("fzf-lua").lsp_workspace_symbols()
  end, opts)
  vim.keymap.set("n", "<leader>fi", function()
    require("fzf-lua").lsp_implementations()
  end, opts)

  if client:supports_method("textDocument/codeAction", bufnr) then
    vim.keymap.set("n", "<leader>oi", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
        bufnr = bufnr,
      })
      vim.defer_fn(function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, 50)
    end, opts)
  end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("pyright", {})
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("gopls", {})
vim.lsp.config("jsonls", {})
vim.lsp.config("tailwindcss", {})
vim.lsp.config("pyright", {})
vim.lsp.config("ruff", {})
vim.lsp.config("bashls", {})
vim.lsp.config("clangd", {})
vim.lsp.enable('jdtls', {})
vim.lsp.enable('roslyn_ls')

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "bashls",
  "ts_ls",
  "gopls",
  "jsonls",
  "tailwindcss",
  "pyright",
  "ruff",
  "bashls",
  "clangd",
  "jdtls",
  "roslyn_ls",
})

require("mason").setup({})

require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<C-Space>"] = { "show", "hide" },
    ["<C-y>"] = { "accept", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },
  appearance = { nerd_font_variant = "mono" },
  completion = { menu = { auto_show = true } },
  sources = { default = { "lsp", "path", "buffer", "snippets" } },
  snippets = {
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
  },

  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = { download = true },
  },
})

vim.lsp.config["*"] = {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
}

require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
  },
})

keymap.set("n", "<leader>fo", function()
  require("conform").format({ async = true, lsp_fallback = true })
end)

vim.api.nvim_create_user_command("Jq", function(opts)
  local filter = opts.args ~= "" and opts.args or "."
  vim.cmd("%" .. "!" .. "jq " .. filter)
end, { nargs = "?", desc = "Format buffer with jq" })

-- DAP (.NET / netcoredbg)
packadd("nvim-dap")
packadd("nvim-nio")
packadd("nvim-dap-ui")

local dap = require("dap")
local dapui = require("dapui")

dapui.setup({})

-- Open/close the dap-ui automatically with a session.
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- netcoredbg (Samsung, OSS) as the .NET DAP adapter. History of what failed:
--  * vsdbg supports net10 but sends a licensed `handshake` reverse-request that
--    only Microsoft tooling (VS/VS Code) can answer — nvim-dap can't, so it's
--    permanently stuck at "Error processing 'initialize' request".
--  * sharpdbg 0.1.4 is net10-native and needs no handshake, but IGNORES
--    setExceptionBreakpoints: it halts on every first-chance exception. DAS throws
--    a torrent of those per request, and sharpdbg then desyncs the CoreCLR
--    (CORDBG_E_PROCESS_NOT_SYNCHRONIZED) — the session thrashes and never reaches
--    a real breakpoint. Unusable for DAS.
--  * The old netcoredbg 3.1.3 (Mason) predates net10 and can't attach.
-- netcoredbg 3.2.0-1092 (build 2026-06-25, POST net10) attaches to net10 AND
-- honors exception filters, so DAS's first-chance storm is ignored.
-- Install: download latest linux-amd64 from github.com/Samsung/netcoredbg/releases
-- To debug adapter issues: dap.set_log_level("TRACE") and add
-- "--engineLogging=" .. vim.fn.expand("~/.cache/nvim/netcoredbg.log") to args below.
dap.set_log_level("TRACE")

dap.adapters.coreclr = {
  type = "executable",
  command = vim.fn.expand("~/.local/netcoredbg-latest/netcoredbg/netcoredbg"),
  args = { "--interpreter=vscode", "--engineLogging=" .. vim.fn.expand("~/.cache/nvim/netcoredbg.log") },
}

local das_project = "/home/quangan/dev/az/MITS11/DAS/DAS"

-- Build DAS (Debug) before launching so <F5> never debugs a stale dll.
-- nvim-dap resolves `program` inside a coroutine, so we build asynchronously
-- (jobstart) and yield/resume rather than blocking with vim.fn.system — a
-- blocking build pumps the event loop under nvim-dap and corrupts its rpc
-- coroutine. Erroring here gates the launch on a successful build.
local function build_das()
  local co = coroutine.running()
  vim.notify("Building DAS…", vim.log.levels.INFO)
  local out = {}
  local function collect(_, data)
    if data then vim.list_extend(out, data) end
  end
  vim.fn.jobstart({ "dotnet", "build", das_project, "-c", "Debug", "--nologo" }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = collect,
    on_stderr = collect,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("DAS build succeeded", vim.log.levels.INFO)
      else
        vim.notify("DAS build failed:\n" .. table.concat(out, "\n"), vim.log.levels.ERROR)
      end
      coroutine.resume(co, code == 0)
    end,
  })
  if not coroutine.yield() then
    error("DAS build failed — aborting debug session")
  end
end

-- Find the freshly-built DAS dll (Debug build) so we don't have to retype paths.
local function das_dll()
  build_das()
  local hint = das_project .. "/bin/Debug/net10.0/MITS11.DAS.dll"
  if vim.fn.filereadable(hint) == 1 then
    return hint
  end
  return vim.fn.input("Path to dll: ", das_project .. "/bin/Debug/net10.0/", "file")
end

dap.configurations.cs = {
  -- Attach is first so it's the default <F5> choice: a DAS instance is normally
  -- already running (bun run das:dev), and attach never triggers a build.
  {
    type = "coreclr",
    name = "DAS (attach)",
    request = "attach",
    -- Pick the DAS *web server*, excluding the `--workflow-worker` child
    -- processes (they load the same dll but never run controller code, so
    -- attaching to one makes breakpoints report frames from unrelated worker
    -- code — "Invalid cursor line: out of range" and no stepping).
    processId = function()
      return require("dap.utils").pick_process({
        filter = function(proc)
          return proc.name:find("MITS11.DAS", 1, true)
            -- and not proc.name:find("--workflow-worker", 1, true)
        end,
      })
    end,
  },
  {
    type = "coreclr",
    name = "DAS (launch — builds first)",
    request = "launch",
    program = das_dll,
    cwd = "/home/quangan/dev/az/MITS11/DAS/DAS",
    env = {
      ASPNETCORE_ENVIRONMENT = "Development",
    },
    stopAtEntry = false,
    -- Run DAS in a terminal buffer (via runInTerminal) so its console output
    -- (e.g. "[StartupTiming] WebApplication.CreateBuilder()…") goes there and
    -- doesn't leak into sharpdbg's DAP stream, which corrupts the protocol and
    -- kills nvim-dap's rpc coroutine ("cannot resume dead coroutine").
    console = "integratedTerminal",
  },
}

-- sharpdbg 0.1.4 stops on *every* first-chance exception and ignores the DAP
-- exception filter (setExceptionBreakpoints has no effect). DAS throws many
-- first-chance exceptions during startup, so the session halts on the first one
-- — in library code with no source ("unavailable location") — and never reaches
-- your breakpoints. Auto-resume on exception stops so breakpoints are reachable.
-- Trade-off: you won't break on unhandled exceptions; a crash still terminates
-- the process and its stack trace shows up in the DAS terminal buffer.
dap.listeners.after.event_stopped["coreclr_skip_first_chance"] = function(session, body)
  if body.reason == "exception" then
    session:request("continue", { threadId = body.threadId }, function() end)
  end
end

-- Those first-chance exceptions land in library code with no source, so nvim-dap
-- emits "Debug adapter stopped at unavailable location" (WARN) on each one before
-- the listener above resumes. It's cosmetic noise here — drop just that message
-- while leaving every other nvim-dap notification intact.
do
  local dap_utils = require("dap.utils")
  local orig_notify = dap_utils.notify
  dap_utils.notify = function(msg, level, opts)
    if msg == "Debug adapter stopped at unavailable location" then
      return
    end
    return orig_notify(msg, level, opts)
  end
end

local dapkeys = {
  { "<F5>", function() dap.continue() end, "dap continue/start" },
  { "<F10>", function() dap.step_over() end, "dap step over" },
  { "<F11>", function() dap.step_into() end, "dap step into" },
  { "<F12>", function() dap.step_out() end, "dap step out" },
  { "<leader>db", function() dap.toggle_breakpoint() end, "dap toggle breakpoint" },
  { "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, "dap conditional breakpoint" },
  { "<leader>dr", function() dap.repl.toggle() end, "dap repl" },
  { "<leader>du", function() dapui.toggle() end, "dap ui toggle" },
  { "<leader>dt", function() dap.terminate() end, "dap terminate" },
}
for _, m in ipairs(dapkeys) do
  keymap.set("n", m[1], m[2], { desc = m[3] })
end
