require "nvchad.mappings"

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

-- LSP Mappings (lifted from: )
map("n", "<leader>sh", vim.lsp.buf.signature_help)
