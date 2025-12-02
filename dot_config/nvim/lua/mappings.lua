require("nvchad.mappings")
local utils = require('utils')

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- use 'jk' in insert mode to simulate an ESC keypress
map("i", "jk", "<ESC>")

-- Tmux Navigate Mappings
map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })
map("n", "<C-\\>", "<Cmd>TmuxNavigateLastActive<CR>", { silent = true })

-- LSP Mappings
map("n", "<leader>sh", vim.lsp.buf.signature_help)

-- Additional Telescope mappings
map("n", "<leader>fg", "<Cmd>Telescope git_status<CR>")
map("n", "<leader>tg", "<Cmd>Telescope live_grep<CR>")
map("n", "<leader>tr", "<Cmd>Telescope lsp_references<CR>")
-- map("n", "<leader>t@", "<Cmd>Telescope lsp_document_symbols<CR>")
map("n", "<leader>tt", "<Cmd>Telescope treesitter<CR>")
map("n", "<leader>to", "<Cmd>Telescope oldfiles<CR>")
map("n", "<leader>fS", "<Cmd>Telescope treesitter<CR>")
map("n", "<leader>ts", "<Cmd>Telescope spell_suggest<CR>")
map("n", "<leader>td", "<Cmd>Telescope diagnostics<CR>")

map("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting clipboard" })

-- map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek definition" })
--
-- <C-i> is interpretted as tab in the terminal. So map the <C-i> to something else
map("n", "<leader>j", "<C-i>", { noremap = true, silent = true, desc = "Jump forward in jumplist" })

map("n", "<leader>H", utils.toggle_gitignored, { desc = "Toggle gitignored files in nvtree and Telescope" })

-- Copy the current method, class name, and relative file path for pytest
vim.keymap.set("n", "<leader>ty", function()
  local file_path = vim.fn.expand("%:.") -- relative path to current file
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1]

  local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)
  local method = vim.fn.expand("<cword>")
  local class

  -- Walk backwards from the cursor to find enclosing method and class
  for i = #lines, 1, -1 do
    local line = lines[i]
    if not class then
      class = line:match("^%s*class%s+([%w_]+)")
    end
    if class then break end
  end

  if not method then
    vim.notify("No method found under cursor", vim.log.levels.WARN)
    return
  end

  -- Replace / with . and remove .py extension
  -- local python_path = file_path:gsub("/", "."):gsub("%.py$", "")
  -- local full_test_id = python_path
  local full_test_id = file_path

  if class then
    full_test_id = full_test_id .. "::" .. class
  end

  full_test_id = full_test_id .. "::" .. method

  -- Copy to system clipboard
  vim.fn.setreg("+", full_test_id)
  vim.notify("Copied test path: " .. full_test_id)
end, { desc = "Copy pytest test identifier", noremap = true, silent = true })


vim.keymap.set("n", "<leader>rr", function()
  local tele = require('telescope')
  tele.load_extension("rest")
end, { desc = "Open rest.nvim plugin" })

map("n", "<leader>X", require('nvchad.tabufline').closeAllBufs)

-- DAP mappings
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<leader>du", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<leader>dq", function() require("dap").terminate() end, { desc = "Terminate" })
map("n", "<leader>dd", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })
