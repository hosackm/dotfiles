require("nvchad.configs.lspconfig").defaults()

local shims = vim.env.HOME .. "/.asdf/shims/"

local servers = {
  html = {},
  cssls = {},
  pyright = {},
  ruff = {},
  clangd = {},
  gopls = { cmd = { shims .. "gopls" } },
  golangci_lint_ls = { cmd = { shims .. "golangci-lint" } },
  rust_analyzer = {},
  ts_ls = {},

  elixirls = {
    cmd = { "/Users/hosack/.local/share/elixir-ls/language_server.sh" },
  },

  zls = {
    settings = {
      zls = {
        zig_exe_path = shims .. "zig",
        zig_lib_path = shims .. "../installs/zig/0.15.1/lib",
      },
    },
  },
}

-- read :h vim.lsp.config for changing options of lsp servers 
-- vim.lsp.enable(servers)

for name, config in pairs(servers) do
  vim.lsp.config[name] = config
  vim.lsp.enable(name)
end
