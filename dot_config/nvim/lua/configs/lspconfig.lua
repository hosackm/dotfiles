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
  "ruff_lsp",
  "zls",
  "clangd",
  "gopls",
  "golangci_lint_ls"
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
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.elixirls.setup{
  cmd = { "/Users/hosack/.local/share/elixir-ls/language_server.sh" };
}
