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

-- LSP Mappings
map("n", "<leader>sh", vim.lsp.buf.signature_help)

-- Additional Telescope mappings
map("n", "<leader>fg", "<Cmd>Telescope git_status<CR>")
map("n", "<leader>tg", "<Cmd>Telescope live_grep<CR>")
map("n", "<leader>tr", "<Cmd>Telescope lsp_references<CR>")
-- map("n", "<leader>t@", "<Cmd>Telescope lsp_document_symbols<CR>")
map("n", "<leader>t@", "<Cmd>Telescope treesitter<CR>")
map("n", "<leader>to", "<Cmd>Telescope oldfiles<CR>")
map("n", "<leader>fS", "<Cmd>Telescope treesitter<CR>")
map("n", "<leader>ts", "<Cmd>Telescope spell_suggest<CR>")
map("n", "<leader>td", "<Cmd>Telescope diagnostics<CR>")

map("x", "<leader>pp", [["_dP]], { desc = "Paste without overwriting clipboard" })

map({ "n", "t" }, "<leader>gg", function()
    require("nvchad.term").toggle { pos = "float", id = "floatTerm", float_opts = {
        row = 0.05,
        col = 0.05,
        width = 0.9,
        height = 0.8,
    }, cmd = "lazygit" }
end, { desc = "terminal toggle floating term" })
