local dap, dapui = require('dap'), require('dapui')
local dapgo = require('dap-go')
dapui.setup()
dapgo.setup()
dap.listeners.before.attach.dapui_config = function()
 dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
 dapui.open()
end


-- Optional Go keymaps
vim.keymap.set("n", "<leader>dt", function()
  require("dap-go").debug_test()
end, { desc = "DAP: Debug Go Test" })

vim.keymap.set("n", "<leader>dl", function()
  require("dap-go").debug_last()
end, { desc = "DAP: Debug Last Go Test" })

-- Include the next few lines until the comment only if you feel you need it
dap.listeners.before.event_terminated.dapui_config = function()
 dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
 dapui.close()
end
