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
  require("nvim-tree.api").tree.toggle({ find_file = true, focus = true })
end, { desc = "Toggle NvimTree and find current file" })
