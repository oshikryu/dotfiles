-- ─────────────────────────────────────────────
-- 󰘳 Basic Settings
-- ─────────────────────────────────────────────
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.cmd([[source ~/.dot/vimrc]])
vim.cmd([[colorscheme gruvbox]])

-- ─────────────────────────────────────────────
-- 󰙅 Plugins: NvimTree + Icons
-- ─────────────────────────────────────────────
require("nvim-tree").setup()
require("nvim-web-devicons").setup()

vim.keymap.set('n', '<leader>j', function()
  require("nvim-tree.api").tree.open({ find_file = true, focus = true })
end, { desc = "Open NvimTree to current file" })

-- ─────────────────────────────────────────────
--  Tree-sitter Setup
-- ─────────────────────────────────────────────
require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "typescript", "tsx", "javascript", "python", "scala",
    "lua", "vim", "bash", "yaml", "json"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- ─────────────────────────────────────────────
--  LSP Setup
-- ─────────────────────────────────────────────
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- TypeScript
lspconfig.ts_ls.setup({
  capabilities = capabilities,
})

-- Python
lspconfig.pyright.setup {
  capabilities = capabilities,
}

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

-- LSP diagnostics keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic under cursor' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics location list' })

-- ─────────────────────────────────────────────
-- 󰘳 Autocompletion (nvim-cmp)
-- ─────────────────────────────────────────────
local cmp = require("cmp")

cmp.setup {
  sources = {
    { name = "nvim_lsp" },
    -- { name = "luasnip" }, -- uncomment if using snippets
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
}

-- ─────────────────────────────────────────────
--  DAP Keymaps
-- ─────────────────────────────────────────────
local dap = require("dap")

vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Set Conditional Breakpoint" })

-- ─────────────────────────────────────────────
--  Misc Keymaps
-- ─────────────────────────────────────────────
vim.keymap.set("i", "<F2>", function()
  vim.o.paste = not vim.o.paste
  print("Paste mode: " .. tostring(vim.o.paste))
end, { noremap = true })
