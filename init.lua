local opt = vim.opt

vim.cmd.colorscheme("habamax")

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

--quick fix
keymap.set("n", "<C-M-j>", "<cmd>:cnext<CR>")
keymap.set("n", "<C-M-k>", "<cmd>:cprev<CR>")

keymap.set("n", "<leader>pa", function() -- show file path
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = "Copy full file path" })

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

require("status_line")

vim.pack.add({
  "https://www.github.com/ibhagwan/fzf-lua",
  "https://www.github.com/nvim-tree/nvim-tree.lua",
  "https://www.github.com/echasnovski/mini.nvim",
  "https://www.github.com/lewis6991/gitsigns.nvim",
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
})

local function packadd(name)
  vim.cmd("packadd " .. name)
end

packadd("nvim-tree.lua")
packadd("fzf-lua")
packadd("mini.nvim")
packadd("gitsigns.nvim")
packadd("nvim-treesitter")
packadd("oil.nvim")

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

require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})


require("gitsigns").setup({
  signs = {
    add = { text = "\u{2590}" },        -- ▏
    change = { text = "\u{2590}" },     -- ▐
    delete = { text = "\u{2590}" },     -- ◦
    topdelete = { text = "\u{25e6}" },  -- ◦
    changedelete = { text = "\u{25cf}" }, -- ●
    untracked = { text = "\u{25cb}" },  -- ○
  },
  signcolumn = true,
  current_line_blame = false,
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
vim.lsp.config("json_ls", {})

vim.lsp.enable({
  "lua_ls",
  "pyright",
  "bashls",
  "ts_ls",
  "gopls",
  "json_ls",
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

keymap.set("n", "<leader>fo", function()
  vim.lsp.buf.format()
end)

