rex.bind("alt+h", "pane.resize", { direction = "left" })
rex.bind("alt+l", "pane.resize", { direction = "right" })
rex.bind("alt+k", "pane.resize", { direction = "up" })
rex.bind("alt+j", "pane.resize", { direction = "down" })

rex.bind("ctrl+h", "pane.focus.left")
rex.bind("ctrl+j", "pane.focus.down")
rex.bind("ctrl+k", "pane.focus.up")
rex.bind("ctrl+l", "pane.focus.right")

-- https://github.com/baggiponte/rex-navigator.nvim
local data = os.getenv('HOME') .. '/.local/share'
local plugin = data .. '/nvim/lazy/rex-navigator.nvim'
local ok, err = pcall(function()
  dofile(plugin .. '/rex/navigator.lua').setup()
end)
if not ok then
  rex.log('warn', 'rex-navigator not loaded: ' .. tostring(err))
end
