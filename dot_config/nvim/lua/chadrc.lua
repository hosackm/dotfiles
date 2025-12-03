-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
--
-- matt: add autocmds
require('custom.autocmds')

---@type ChadrcConfig
local M = {
  base46 = {
    theme = "kanagawa",
  },
  ui = {
    statusline = {
      -- theme = "default",
      -- theme = "minimal",
      -- theme = "vscode",
      -- theme = "vscode_colored",
      -- theme = "minimal"
    }
  }
}

return M

