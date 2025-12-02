local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

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

local default = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

for server, opts in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", default, opts))
end
