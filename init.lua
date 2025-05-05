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

local dap = require('dap')

dap.adapters.go = function(callback, _)
  local port = 38697
  local handle
  handle = vim.loop.spawn("dlv", {
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }, function(code)
    handle:close()
    print("Delve exited with code", code)
  end)
  vim.defer_fn(function()
    callback({ type = "server", host = "127.0.0.1", port = port })
  end, 100)
end

dap.configurations.go = {
  {
    type = "go",
    name = "Run CLI with args",
    request = "launch",
    program = "/Users/ryuta.oshikiri/projects/develop-domino-connect-service/cmd/dom",
    args = {
      "connect",
      "6801786a3420ca57e5b619c2",
      "--domino-api-endpoint=https://your-api.domino.tech",
    },
  },
}
