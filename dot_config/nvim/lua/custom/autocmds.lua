local autocmd  = vim.api.nvim_create_autocmd
local augroup  = vim.api.nvim_create_augroup

-- Helper: set tab width per filetype
local function set_tab_width(ft, size)
  autocmd("FileType", {
    pattern = ft,
    callback = function()
      vim.bo.tabstop = size
      vim.bo.shiftwidth = size
      vim.bo.softtabstop = size
      vim.bo.expandtab = true
    end,
  })
end

set_tab_width("javascript", 2)
set_tab_width("html", 2)
set_tab_width("python", 4)
set_tab_width("go", 4)

-- Ensure file ends with a single blank line
local newline_ft = {
  javascript = true,
  typescript = true,
  html = true,
  python = true,
  go = true,
  lua = true,
  sh = true,
}

autocmd("BufWritePre", {
  group = augroup("EnsureEOFNewline", {}),
  callback = function()
    if not newline_ft[vim.bo.filetype] then
      return
    end

    local last_line = vim.fn.getline("$")
    if not last_line:match("^%s*$") then
      vim.api.nvim_buf_set_lines(0, -1, -1, false, { "" })
    end

    -- optional: LSP format on save
    pcall(function()
      vim.lsp.buf.format({ async = false })
    end)
  end,
})

-- Trim trailing whitespace
autocmd("BufWritePre", {
  group = augroup("TrimWhitespace", {}),
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

