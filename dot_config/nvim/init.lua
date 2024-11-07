vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- Bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- Load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- Load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Function to set tab and shift widths
local function set_tab_width(filetype, tabwidth)
  vim.cmd(string.format("autocmd FileType %s setlocal tabstop=%d shiftwidth=%d", filetype, tabwidth, tabwidth))
end

-- Set tab width by filetype
set_tab_width("javascript", 2)
set_tab_width("html", 2)
set_tab_width("python", 4)
set_tab_width("go", 4)

-- Ensure a blank line at the end of the file on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
      local last_line = vim.fn.getline("$")
      if not last_line:match("^%s*$") then
          vim.api.nvim_buf_set_lines(0, -1, -1, false, { "" })
      end
  end,
})

-- Auto trim spaces at end of line
vim.cmd('augroup TrimTrailingWhitespace')
vim.cmd('autocmd!')
vim.cmd('autocmd BufWritePre * lua TrimTrailingWhitespace()')
vim.cmd('augroup END')
function TrimTrailingWhitespace()
  local buffer = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  for i, line in ipairs(lines) do
    lines[i] = string.gsub(line, '%s+$', '')
  end
  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
end
