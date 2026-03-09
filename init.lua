-- ─────────────────────────────────────────────
-- lazy.nvim Bootstrap
-- ─────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ─────────────────────────────────────────────
-- Leader + netrw disable (must be before lazy)
-- ─────────────────────────────────────────────
vim.g.mapleader = ","
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Plugin g: vars (read at load time)
vim.g.NERDSpaceDelims = 1
vim.g.NERDCompactSexyComs = 1
vim.g.NERDDefaultAlign = "left"
vim.g.NERDAltDelims_java = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDTrimTrailingWhitespace = 1
vim.g.fzf_command_prefix = "Fzf"
vim.g.airline_highlighting_cache = 1
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g.delimitMate_expand_cr = 1
vim.g.vim_json_syntax_conceal = 0
vim.g.jsx_ext_required = 0

-- ─────────────────────────────────────────────
-- Plugins
-- ─────────────────────────────────────────────
require("lazy").setup({
  -- UI
  "ellisonleao/gruvbox.nvim",
  { "nvim-tree/nvim-tree.lua", config = function() require("nvim-tree").setup() end },
  { "nvim-tree/nvim-web-devicons", config = function() require("nvim-web-devicons").setup() end },
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  -- Editing
  "tpope/vim-sensible",
  "scrooloose/nerdcommenter",
  "tpope/vim-surround",
  "Raimondi/delimitMate",
  "sheerun/vim-polyglot",
  -- Git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  -- FZF
  { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end },
  "junegunn/fzf.vim",
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "typescript", "tsx", "javascript", "python", "scala",
        "lua", "vim", "bash", "yaml", "json", "go",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  -- LSP
  "neovim/nvim-lspconfig",
  "scalameta/nvim-metals",
  "nvim-lua/plenary.nvim",
  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  -- DAP
  "mfussenegger/nvim-dap",
  "leoluz/nvim-dap-go",
  "nvim-neotest/nvim-nio",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  -- Languages
  { "fatih/vim-go", build = ":GoUpdateBinaries" },
  "derekwyatt/vim-scala",
  -- Prettier
  {
    "prettier/vim-prettier",
    build = "yarn install",
    ft = { "javascript", "typescript", "css", "less", "scss", "json", "graphql", "markdown", "vue", "yaml", "html" },
  },
}, {
  defaults = { lazy = false },
})

-- ─────────────────────────────────────────────
-- Options
-- ─────────────────────────────────────────────
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.ttyfast = true
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.relativenumber = false
vim.opt.synmaxcol = 1000
vim.opt.clipboard = "unnamed"
vim.opt.backspace = "indent,eol,start"
vim.opt.undolevels = 1000
vim.opt.wildignore:append("**/node_modules/**,**/dist/**,**_site/**,*.swp,*.png,*.jpg,*.gif,*.webp,*.jpeg,*.map,*.bak,*.pyc,*.class,**/out/**")
vim.opt.history = 50
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.autoindent = true
vim.opt.shiftround = true
vim.opt.visualbell = true
vim.opt.errorbells = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.textwidth = 99
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 1
vim.opt.hidden = true
vim.opt.virtualedit = "all"
vim.opt.wildmenu = true
vim.opt.encoding = "utf-8"
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.mmp = 5000
vim.opt.mouse = "a"

-- backup / swap / undo
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = true
vim.opt.undofile = true

if vim.fn.has("unix") == 1 then
  vim.opt.backupdir = vim.env.HOME .. "/.vim/vim/tmp/backup//"
  vim.opt.directory = vim.env.HOME .. "/.vim/vim/tmp/swap//"
else
  vim.opt.backupdir = vim.env.HOME .. "/.dot/vim/tmp/backup//"
  vim.opt.directory = vim.env.HOME .. "/.dot/vim/tmp/swap//"
end
vim.opt.undodir = vim.env.HOME .. "/.vim/undodir"

-- ─────────────────────────────────────────────
-- Colorscheme
-- ─────────────────────────────────────────────
vim.cmd([[colorscheme gruvbox]])

-- ─────────────────────────────────────────────
-- Highlights
-- ─────────────────────────────────────────────
vim.cmd([[
  highlight Search ctermfg=None ctermbg=244
  highlight ColorColumn ctermfg=None ctermbg=239
  highlight SignColumn ctermbg=None
  highlight LineNr ctermfg=229 ctermbg=None
  highlight CursorLineNr cterm=bold ctermbg=238 ctermfg=208
  highlight CursorLine cterm=bold ctermbg=238 ctermfg=NONE
]])

-- ─────────────────────────────────────────────
-- Lua Functions
-- ─────────────────────────────────────────────
local cursorline_enabled = true

local function set_cursorline()
  vim.wo.cursorline = not vim.wo.cursorline
  cursorline_enabled = vim.wo.cursorline
end

local function update_cursorline()
  if cursorline_enabled then
    vim.wo.cursorline = true
  end
end

local function cursor_insert_highlight()
  vim.cmd("highlight CursorLine ctermbg=235")
  vim.cmd("highlight CursorLineNr ctermbg=235")
end

local function cursor_normal_highlight()
  vim.cmd("highlight CursorLine ctermbg=238")
  vim.cmd("highlight CursorLineNr ctermbg=238")
end

local function insert_debug()
  local ft = vim.bo.filetype
  local debug_line
  if ft == "javascript" or ft == "typescript" or ft == "typescriptreact" then
    debug_line = "debugger;"
  elseif ft == "python" then
    debug_line = "import ipdb; ipdb.set_trace()"
  elseif ft == "go" then
    debug_line = "runtime.Breakpoint()"
  elseif ft == "lua" then
    debug_line = 'print("🔍 DEBUG")'
  elseif ft == "sh" or ft == "bash" then
    debug_line = 'echo "DEBUG: $VARIABLE"'
  else
    debug_line = "DEBUGGER_PLACEHOLDER"
  end
  vim.api.nvim_put({ debug_line }, "l", true, true)
end

-- ─────────────────────────────────────────────
-- LSP Setup
-- ─────────────────────────────────────────────
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('ts_ls', { capabilities = capabilities })
vim.lsp.config('pyright', { capabilities = capabilities })
vim.lsp.enable({ 'ts_ls', 'pyright' })

-- Scala / Metals
local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
  local nmap = function(keys, func, desc)
    if desc then desc = "LSP: " .. desc end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end
  nmap("K", vim.lsp.buf.hover, "Hover")
  nmap("gd", vim.lsp.buf.definition, "Goto Definition")
  nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
})

-- ─────────────────────────────────────────────
-- nvim-cmp Setup
-- ─────────────────────────────────────────────
local cmp = require("cmp")
cmp.setup {
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  },
}

-- ─────────────────────────────────────────────
-- Keymaps
-- ─────────────────────────────────────────────
vim.keymap.set("n", "<C-l>", ":nohl<CR><C-l>", { silent = true })
vim.keymap.set("n", "<leader>c", set_cursorline, { silent = true, desc = "Toggle cursorline" })
vim.keymap.set("n", "<leader>=", ":set paste!<CR>", { silent = true })
vim.keymap.set("i", "<F2>", function()
  vim.o.paste = not vim.o.paste
  print("Paste mode: " .. tostring(vim.o.paste))
end, { noremap = true })

-- Fix cursor keys in insert mode
vim.keymap.set("i", "<Esc>A", "<up>", { noremap = true })
vim.keymap.set("i", "<Esc>B", "<down>", { noremap = true })
vim.keymap.set("i", "<Esc>C", "<right>", { noremap = true })
vim.keymap.set("i", "<Esc>D", "<left>", { noremap = true })

-- Q for formatting
vim.keymap.set("n", "Q", "gq")
-- C-U undo breakpoint in insert
vim.keymap.set("i", "<C-U>", "<C-G>u<C-U>", { noremap = true })

-- delimitMate expand
vim.keymap.set("i", "<C-c>", "<CR><Esc>O")

-- NvimTree
vim.keymap.set("n", "<F3>", ":NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("i", "<F3>", "<Esc>:NvimTreeToggle<CR>a", { silent = true })
vim.keymap.set("n", "<leader>j", function()
  require("nvim-tree.api").tree.open({ find_file = true, focus = true })
end, { desc = "Open NvimTree to current file" })

-- FZF
vim.keymap.set("n", "<leader>b", ":FzfBuffers<CR>")
vim.keymap.set("n", "<leader>h", ":FzfHistory<CR>")
vim.keymap.set("n", "<leader>m", ":FzfHistory<CR>")
vim.keymap.set("n", "<leader>t", ":FzfBTags<CR>")
vim.keymap.set("n", "<leader>T", ":FzfTags<CR>")
vim.keymap.set("n", "<C-p>", ":FzfGitFiles --exclude-standard --others --cached<CR>")
vim.keymap.set("n", "<leader>gt", ":FzfRg<CR>")

-- Console.log shortcuts (remap=true so visual/normal can trigger insert mapping)
vim.keymap.set("i", "cll", "console.log()<Esc><S-f>(a")
vim.keymap.set("v", "cll", "yocll<Esc>p", { remap = true })
vim.keymap.set("n", "cll", "yiwocll<Esc>p", { remap = true })

-- Insert debug statement
vim.keymap.set("n", "<leader>d", insert_debug, { desc = "Insert debug statement" })

-- LSP diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics location list" })

-- DAP
vim.keymap.set("n", "<F5>", function() require("dap").continue() end, { desc = "DAP: Continue" })
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end, { desc = "DAP: Step Out" })
vim.keymap.set("n", "<Leader>b", function() require("dap").toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>B", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Set Conditional Breakpoint" })
vim.keymap.set("n", "<Leader>dr", function() require("dap").repl.open() end)
vim.keymap.set("n", "<Leader>dl", function() require("dap").run_last() end)
vim.keymap.set("n", "<Leader>w", function() require("dapui").open() end)
vim.keymap.set("n", "<Leader>W", function() require("dapui").close() end)

-- ─────────────────────────────────────────────
-- Autocommands
-- ─────────────────────────────────────────────
-- Cursor highlight
vim.api.nvim_create_augroup("updateCursor", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = "updateCursor",
  callback = update_cursorline,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = "updateCursor",
  callback = function() vim.wo.cursorline = false end,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  group = "updateCursor",
  callback = cursor_insert_highlight,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = "updateCursor",
  callback = cursor_normal_highlight,
})

-- Restore cursor position on BufReadPost
vim.api.nvim_create_augroup("vimrcEx", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "vimrcEx",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- Git commits
vim.api.nvim_create_augroup("vimCommits", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "vimCommits",
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
  end,
})

-- *.ipy → python
vim.api.nvim_create_augroup("pysetup", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "pysetup",
  pattern = "*.ipy",
  callback = function() vim.bo.filetype = "python" end,
})

-- Filetype detection
vim.api.nvim_create_augroup("fileTypeUpdater", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "fileTypeUpdater",
  pattern = "/etc/nginx/sites-*/*",
  callback = function() vim.bo.filetype = "conf" end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "fileTypeUpdater",
  pattern = "*.jsx",
  callback = function() vim.bo.filetype = "javascript.jsx" end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "fileTypeUpdater",
  pattern = "*.ts",
  callback = function() vim.bo.filetype = "typescript" end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "fileTypeUpdater",
  pattern = "*.tsx",
  callback = function() vim.bo.filetype = "typescriptreact" end,
})

-- Line numbers + tab settings per filetype
vim.api.nvim_create_augroup("setFileNumsAndSpacing", { clear = true })
local number_filetypes = {
  "vim", "python", "javascript", "javascript.jsx", "typescript",
  "html", "css", "less", "scala", "feature", "yaml", "go", "typescriptreact",
}
for _, ft in ipairs(number_filetypes) do
  vim.api.nvim_create_autocmd("FileType", {
    group = "setFileNumsAndSpacing",
    pattern = ft,
    callback = function() vim.opt_local.number = true end,
  })
end

local tab2_filetypes = { "html", "css", "less", "javascript", "scala", "python" }
for _, ft in ipairs(tab2_filetypes) do
  vim.api.nvim_create_autocmd("FileType", {
    group = "setFileNumsAndSpacing",
    pattern = ft,
    callback = function()
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
      vim.opt_local.softtabstop = 2
      if ft == "html" then vim.opt_local.textwidth = 0 end
    end,
  })
end

-- Omnifunc per filetype
vim.api.nvim_create_augroup("autoCompleteGroup", { clear = true })
local omnifuncs = {
  python     = "pythoncomplete#Complete",
  javascript = "javascriptcomplete#CompleteJS",
  typescript = "javascriptcomplete#CompleteJS",
  html       = "htmlcomplete#CompleteTags",
  css        = "csscomplete#CompleteCSS",
  less       = "csscomplete#CompleteCSS",
  scala      = "v:lua.vim.lsp.omnifunc",
}
for ft, omnifunc in pairs(omnifuncs) do
  vim.api.nvim_create_autocmd("FileType", {
    group = "autoCompleteGroup",
    pattern = ft,
    callback = function() vim.bo.omnifunc = omnifunc end,
  })
end

-- Auto-reload init.lua on save
vim.api.nvim_create_augroup("myvimrc", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "myvimrc",
  pattern = vim.fn.expand("~/.dot/init.lua"),
  callback = function() vim.cmd("source " .. vim.fn.expand("~/.dot/init.lua")) end,
})

-- ─────────────────────────────────────────────
-- Load goconfig
-- ─────────────────────────────────────────────
require("goconfig")
