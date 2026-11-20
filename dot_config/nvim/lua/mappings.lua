require("nvchad.mappings")
local utils = require('utils')

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- use 'jk' in insert mode to simulate an ESC keypress
map("i", "jk", "<ESC>")

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

map("n", "<C-h>", "<Plug>(RexNavigateLeft)")
map("n", "<C-j>", "<Plug>(RexNavigateDown)")
map("n", "<C-k>", "<Plug>(RexNavigateUp)")
map("n", "<C-l>", "<Plug>(RexNavigateRight)")

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

-- Markview
map("n", "<leader>md", function() require("markview.commands").toggle() end, { desc = "Toggle markdown preview" })
map("n", "<leader>ms", function() require("markview.commands").splitToggle() end, { desc = "Toggle markdown split-view" })

-- Gitsigns
map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    require('gitsigns').nav_hunk("prev")
  end
end, { desc = "Previous git hunk" })

map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    require('gitsigns').nav_hunk("next")
  end
end, { desc = "Next git hunk" })

map("n", "<leader>gd", function()
  require('gitsigns').preview_hunk()
end, { desc = "Git diff preview" })

map("n", "<leader>spi", function()
  local output = vim.fn.system({ "sh", "-c",
    "spotify_player get key playback | jq -r '.item | \"\\(.name)\\n\\(.artists[0].name)\"'", })
  vim.notify(output, vim.log.levels.INFO, { title = "Spotify" })
end, { desc = "Show currently playing Spotify track" })

map("n", "<leader>spn", function()
  vim.fn.system({ "sh", "-c", "spotify_player playback next" })
end, { desc = "Next track in Spotify" })

map("n", "<leader>spp", function()
  vim.fn.system({ "sh", "-c", "spotify_player playback previous" })
end, { desc = "Previous track in Spotify" })

map("n", "<leader>sp<Space>", function()
  vim.fn.system({ "sh", "-c", "spotify_player playback play-pause" })
end, { desc = "Toggle Spotify playback" })

map("c", "<C-a>", "<Home>", { desc = "Jump cursor to head of command line" })
