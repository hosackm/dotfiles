-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "elixirls",
  "pyright",
  "ruff",
  "zls",
  "clangd",
  "gopls",
  "golangci_lint_ls",
  "rust_analyzer"
}
-- not guaranteed to be correct name. See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- "cmake-language-server",
-- "cmakelint",
-- "cpplint",
-- "cpptools",
-- "delve",
-- "docker-compose-language-service",
-- "dockerfile-language-server",
-- "goimports",
-- "golangci-lint",
-- "golangci-lint-langserver",
-- "gopls",
-- "jsonlint",
-- "lua-language-server",
-- "markdownlint",
-- "mypy",
-- "prettier",
-- "pydocstyle",
-- "pyflakes",
-- "pylint",
-- "pyright",
-- "stylua",
-- "tailwindcss-language-server",

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- single langauge, ie. typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.elixirls.setup {
  cmd = { "/Users/hosack/.local/share/elixir-ls/language_server.sh" },
}

lspconfig.zls.setup {
  settings = {
    zls = {
      zig_exe_path = "/Users/matthosack/.asdf/installs/zig/0.15.1/zig",
      zig_lib_path = "/Users/matthosack/.asdf/installs/zig/0.15.1/lib",
    }
  }
}
