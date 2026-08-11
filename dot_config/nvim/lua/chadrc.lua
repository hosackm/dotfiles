-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
--
-- matt: add autocmds
require('custom.autocmds')

---@type ChadrcConfig
local M = {
  base46 = {
    theme = "catppuccin",
  },
}

return M
