-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.cmd([[source ~/.dot/vimrc]])

-- empty setup using defaults
require("nvim-tree").setup()
require'nvim-web-devicons'.setup()

require('dap-go').setup()
require('goconfig')
-- require'nvim-web-devicons'.get_icons()

vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])

--" Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
-- vim.cmd([[set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}]])
vim.opt.statusline = "%{coc#status()}%{get(b:,'coc_current_function','')}"
