-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.cmd([[source ~/.dot/vimrc]])

-- empty setup using defaults
require("nvim-tree").setup()
require'nvim-web-devicons'.setup()

--  -----------------------------------
--  Tree-sitter Configuration
--  -----------------------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "tsx", "javascript", "python", "scala", "lua", "vim", "bash", "yaml", "json" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Enable LSP
local lspconfig = require("lspconfig")

-- Enable autocompletion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configure tsserver
lspconfig.ts_ls.setup({
  capabilities = capabilities,
})

-- require'nvim-web-devicons'.get_icons()

vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])

--" Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
-- vim.cmd([[set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}]])
-- vim.opt.statusline = "%{coc#status()}%{get(b:,'coc_current_function','')}"

vim.keymap.set('i', '<F2>', function()
  vim.o.paste = not vim.o.paste
  print("Paste mode: " .. tostring(vim.o.paste))
end, { noremap = true, silent = false })

-- Enable jump to open file in vim-tree directory
vim.keymap.set('n', '<leader>j', function()
  require("nvim-tree.api").tree.open({ find_file = true, focus = true })
end, { desc = "Toggle NvimTree and find current file" })


--  -----------------------------------
-- nvim-metals setup
--  -----------------------------------
local metals_config = require("metals").bare_config()

-- Enable status bar provider
metals_config.init_options.statusBarProvider = "on"

-- Optional: Enable debugging support
metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
  -- Example keymaps (optional)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("K", vim.lsp.buf.hover, "[K] Hover")
  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
end

-- Auto start metals when opening scala/sbt files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
})

local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Set Conditional Breakpoint" })
