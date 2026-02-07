local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local share = vim.env.HOME .. "/.local/share"

local servers = {
  html = {},
  cssls = {},
  pyright = {},
  ruff = {},
  clangd = {},
  gopls = {},
  golangci_lint_ls = {},
  rust_analyzer = {},
  ts_ls = {},

  elixirls = {
    cmd = { "/elixir-ls/language_server.sh" },
  },

  zls = {
    settings = {
      zls = {
        zig_exe_path = share .. "/mise/installs/zig/0.15/bin/zig",
        zig_lib_path = share .. "/mise/installs/zig/0.15/lib",
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
  vim.lsp.config[server] = vim.tbl_deep_extend(
    "force",
    default,
    opts
  )

  vim.lsp.enable(server)
end
